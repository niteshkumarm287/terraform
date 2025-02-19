#!/usr/bin/env python3

import argparse
import logging
import os
import sys
from pprint import pprint as pp
from typing import Any, Dict, List

from datadog_api_client import ApiClient, Configuration
from datadog_api_client.v1.api import synthetics_api
from datadog_api_client.v1.model.synthetics_api_test import SyntheticsAPITest
from jinja2 import Environment
from ruamel.yaml import YAML

from shared import PreserveUndefined, get_datadog_configuration

logging.basicConfig(level=logging.DEBUG, format="%(asctime)s - %(levelname)s - %(message)s")

extra_debug = False
dry_run = False


def get_synthetic_url(id: str) -> str:
    dd_site = os.getenv("DD_SITE", "datadoghq.com")
    return f"https://dexcom-prod.{dd_site}/synthetics/details/{id}"


def render_templates(context: Dict[str, Any], templates: List[Dict[str, Any]]) -> List[Dict[str, str]]:
    env = Environment(undefined=PreserveUndefined)

    def render_value(value: Any) -> Any:
        if isinstance(value, str):
            template = env.from_string(value)
            return template.render(context)
        elif isinstance(value, dict):
            return {k: render_value(v) for k, v in value.items()}
        elif isinstance(value, list):
            return [render_value(item) for item in value]
        else:
            return value

    rendered_templates = []
    for template_dict in templates:
        rendered_template = {key: render_value(value) for key, value in template_dict.items()}
        rendered_templates.append(rendered_template)

    return rendered_templates


def get_existing_synthetic_id(configuration: Configuration, name: str) -> str:
    """Check if a synthetic monitor with the given name already exists."""
    with ApiClient(configuration) as api_client:
        api_instance = synthetics_api.SyntheticsApi(api_client)
        try:
            response = api_instance.list_tests()
            for test in response["tests"]:
                if test["name"] == name:
                    return test["public_id"]
        except Exception as e:
            logging.error(f"Error fetching existing synthetic monitors: {e}")
    return None  # Return None if no matching monitor is found


def create_or_update_synthetic(configuration: Configuration, data: Dict[str, Any]) -> Dict[str, Any]:
    """Creates a new synthetic monitor or updates an existing one."""
    with ApiClient(configuration) as api_client:
        api_instance = synthetics_api.SyntheticsApi(api_client)
        synthetic_name = data["name"]
        existing_synthetic_id = get_existing_synthetic_id(configuration, synthetic_name)

        if existing_synthetic_id:
            # Update existing synthetic monitor
            logging.debug(f"Updating synthetic monitor: {synthetic_name} (ID: {existing_synthetic_id})")
            update_url = f"https://api.datadoghq.com/api/v1/synthetics/tests/{existing_synthetic_id}"
            try:
                response = api_instance.update_test(public_id=existing_synthetic_id, body=data)
                logging.debug(f"Synthetic updated successfully, ID: {existing_synthetic_id}")
                return response.to_dict()
            except Exception as e:
                logging.error(f"Error updating synthetic monitor: {e}")
        else:
            # Create new synthetic monitor
            logging.debug(f"Creating new synthetic monitor: {synthetic_name}")
            try:
                synthetic_data = SyntheticsAPITest(**data)
                response = api_instance.create_synthetics_api_test(body=synthetic_data)
                logging.debug(
                    f"Synthetic created successfully, ID: {response['public_id']}, URL: {get_synthetic_url(response['public_id'])}"
                )
                return response.to_dict()
            except Exception as e:
                logging.error(f"Error creating synthetic monitor: {e}")

    return None


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--config", help="YAML config for project", required=True)
    parser.add_argument("-t", "--template", help="YAML template for a synthetic", required=True)
    parser.add_argument("-d", "--dry-run", help="(Optional) When set, synthetic is not actually created", action="store_true", default=False, required=False)

    try:
        args = parser.parse_args()
    except Exception as e:
        logging.error(f"There was a problem parsing arguments: {e}")
        sys.exit(1)

    try:
        datadog_configuration = get_datadog_configuration()
    except Exception as e:
        logging.error(f"There was a problem getting the Datadog configuration: {e}")
        sys.exit(1)

    config_file = args.config
    template_file = args.template
    dry_run = args.dry_run

    yaml = YAML()

    try:
        logging.debug(f"Parsing configs from file: {args.config}")
        with open(config_file, "r") as file:
            configs = yaml.load(file)

        with open(template_file, "r") as file:
            synthetic_template = yaml.load(file)

        for config in configs:
            synthetic_values = config["synthetics"]

            rendered_templates = render_templates(synthetic_values, synthetic_template)
            if len(rendered_templates) != 1:
                logging.error("There was a problem rendering the template")
            rendered_template = rendered_templates[0]
            pp(synthetic_values)

            default_tags = [
                f"env:{config.get('env', 'dev')}",  # env is clinical-1, prodvnveast, etc.
                "team:sre",
            ]

            debug_tag = os.getenv("DEBUG_TAG", None)
            if debug_tag is not None:
                debug_tag = f"test:{debug_tag}"
                default_tags.append(debug_tag)

            rendered_template["tags"] = rendered_template.get("tags", []) + default_tags

            if dry_run:
                logging.debug("Dry run enabled, not creating synthetic")
                pp(rendered_template)
            else:
                create_or_update_synthetic(datadog_configuration, rendered_template)

    except FileNotFoundError as e:
        logging.error(f"File not found: {e}")

    except Exception as e:
        logging.error(f"There was a problem: {e}")


if __name__ == "__main__":
    main()
