"""
Create a release body for a GitHub release.

requirements:
    pip3 install requests Jinja2 html2markdown
"""

import argparse
import requests
from jinja2 import Template
from pathlib import Path
from html2markdown import convert


TEMPLATE_PATH = Path("readme-assets/RELEASE_BODY.md.j2")
VERSION_DATA_URL = "https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=30"

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("version", help="The version of the release.")
    
    args = parser.parse_args()

    # Get change log for the specified version
    metadata = requests.get(VERSION_DATA_URL).json()
    results = metadata["ResultSet"]["Results"]
    for result in results:
        if result["version"] == args.version:
            changelog = result["content"]
            break
    else:
        raise ValueError("Could not find version in metadata.")
    
    # Convert HTML to markdown
    changelog = convert(changelog)


    template = Template(TEMPLATE_PATH.read_text())
    body = template.render(version=args.version, changelog=changelog)

    print(body)




    