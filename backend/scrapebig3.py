# pip3 install beautifulsoup4
import requests
from bs4 import BeautifulSoup

base_urls = ["https://www.nytimes.com/", "https://www.bbc.com/news/", "https://www.npr.org/sections/news/"]

section_urls = {}

for base_url in base_urls:
    response = requests.get(base_url)
    if (response.status_code == 200):
        soup = BeautifulSoup(response.content, "html.parser")
        a_tags = soup.find_all("a")

        for a_tag in a_tags:
            if "href" in a_tag.attrs:
                if ((base_url == "https://www.nytimes.com/" or base_url == "https://www.npr.org/sections/news/") and (a_tag["href"][:8] == "/section" or a_tag["href"][:9] == "/sections")):
                    if (base_url == "https://www.nytimes.com/"):
                        if (a_tag["href"][9:].isalpha()):
                            if (a_tag["href"][9:] not in section_urls):
                                section_urls[a_tag["href"][9:]] = set([str(base_url + a_tag["href"][1:])])
                            else:
                                section_urls[a_tag["href"][9:]].add(base_url + a_tag["href"][1:])
                    elif (a_tag["href"][:14] != "/sections/news"):
                        if (a_tag["href"][10:-1] not in section_urls):
                            section_urls[a_tag["href"][10:-1]] = set([str(base_url[:20] + a_tag["href"][1:])])
                        else:
                            section_urls[a_tag["href"][10:-1]].add(base_url[:20] + a_tag["href"][1:])
                elif base_url == "https://www.bbc.com/news/":
                    if (a_tag["href"][:5] == "/news" and len(a_tag["href"]) > 6 and not any(char.isdigit() for char in a_tag["href"])):
                        if (a_tag["href"][6:12] == "world/"):
                            if (a_tag["href"][6:11] not in section_urls):
                                section_urls[a_tag["href"][6:11]] = set([str(base_url + a_tag["href"][6:])])
                            else:
                                section_urls[a_tag["href"][6:11]].add(base_url + a_tag["href"][6:])
                        elif (a_tag["href"][6:15] == "business/"):
                            if (a_tag["href"][6:14] not in section_urls):
                                section_urls[a_tag["href"][6:14]] = set([str(base_url + a_tag["href"][6:])])
                            else:
                                section_urls[a_tag["href"][6:14]].add(base_url + a_tag["href"][6:])
                        elif (a_tag["href"][6:] not in section_urls):
                            section_urls[a_tag["href"][6:]] = set([str(base_url + a_tag["href"][6:])])
                        else:
                            section_urls[a_tag["href"][6:]].add(base_url + a_tag["href"][6:])         
    else:
        print("Failed to fetch", base_url)

print("Sections URLs:")
for section in section_urls:
    print(section)
    for i in section_urls[section]:
        print(i)
    print()