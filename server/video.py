from bs4 import BeautifulSoup
import requests

HEADERS = {
    'User-Agent': 'My User Agent 1.0',
    'From': 'user@domain.com'
}

def getVideoFromArticle(uri):
    soup = BeautifulSoup(requests.get(uri, headers=HEADERS).text, 'html.parser')
    video = soup.find("iframe", {"class": "youtube-player"})
    if video != None:
        return video["src"]
    return None
    
def getVideoFromAzure(title):
    print('hit')
    return None