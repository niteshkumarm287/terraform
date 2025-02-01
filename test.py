import requests

def read_urls(file_path):
    """
    Reads URLs from the given text file.
    Each URL should be on a separate line.
    Returns a list of URLs.
    """
    try:
        with open(file_path, "r") as file:
            # Strip whitespace and ignore empty lines
            urls = [line.strip() for line in file if line.strip()]
        return urls
    except Exception as e:
        print(f"Error reading URL file: {e}")
        return []

# Specify the text to search for (case-insensitive)
search_text = "dexcom"

# Path to the text file containing URLs
urls_file = "urls.txt"
urls = read_urls(urls_file)

if not urls:
    print("No URLs found. Please check the file and try again.")
else:
    # Loop through each URL and check for the search text
    for url in urls:
        try:
            # Fetch the content of the URL
            response = requests.get(url, timeout=10)
            # Check if the request was successful
            if response.status_code == 200:
                # Search for the text (case insensitive)
                if search_text.lower() in response.text.lower():
                    print(f"SUCCESS: Text '{search_text}' found on {url} - Status: 200")
                else:
                    print(f"FAILURE: Text '{search_text}' not found on {url} - Status: 500")
            else:
                print(f"FAILURE: Unable to retrieve {url} - HTTP Status Code: {response.status_code}")
        except Exception as e:
            print(f"ERROR: Exception occurred while retrieving {url}: {e}")

print("Script execution completed.")
