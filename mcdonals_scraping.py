import requests
import re
from unidecode import unidecode
import os
import shutil

if os.path.exists("./menu-items"):
    shutil.rmtree("./menu-items")
url = 'https://mcdonalds.com.pk/full-menu/'  


response = requests.get(url)


if response.status_code == 200:

    os.makedirs("./menu-items")


    html_content = response.text
    pattren=r'category-title\">(.*?)</span>'

    matches = re.findall(pattren, html_content)


    for match in matches:
        lowercase=match.lower()
        text_without_diacritics = unidecode(lowercase)
        pattren="&amp;"
        new_text = re.sub(pattren, "and", text_without_diacritics)
        new_text = re.sub(" ", "-", new_text)

        print(f"fetching {new_text}...")
        response2 = requests.get(url+new_text+"/")
        if response2.status_code == 200:
            html = response2.text
            no=1
            pattren=r'categories-item-name\">(.*?)</span>'
            matches2 = re.findall(pattren, html)
            with open(f"./menu-items/{match}.txt", "a") as file:
                for name in matches2:
                    print(name)
                    file.write(f"{no}) "+name+"\n")
                    no+=1
        
            print("written to file")

else:
    print(f"Failed to retrieve HTML. Status code: {response.status_code}")
