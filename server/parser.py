import requests
from bs4 import BeautifulSoup
import hashlib
from video import *

HEADERS = {
    'User-Agent': 'My User Agent 1.0',
    'From': 'user@domain.com'
}

class Parser:

    def __init__(self):
        self.NEWS_URL = "https://news.microsoft.com/en-ca/"
        self.soup = BeautifulSoup(requests.get(self.NEWS_URL, headers=HEADERS).text, 'html.parser')

    def getParsedInfo(self, previousCache):
        newCache = dict()
        self.getXlImage(newCache)
        self.getLImages(newCache)
        self.getMImages(newCache)
        # print(newCache)
        return checkDifference(newCache, previousCache["data"]), newCache

    def getXlImage(self, newCache):
        xlDiv = self.soup.find("div", {"class": "mnc-lg-panel"})
        title = xlDiv.a["ms.title"]
        image = xlDiv.img["src"]
        article = xlDiv.a["href"]
        hashed = hash_string(title)
        vid = getVideo(article, title)
        if vid != None:
            newCache[hashed] = {"title": title, "imgHREF": image, "imageSize": "xl", "articleHREF": article, "videoHREF":  vid}

    def getLImages(self, newCache):
        lDivs = self.soup.find_all("div", {"class": "mnc-md-panel"})
        for div in lDivs:
            title = div.a["ms.title"]
            image = div.img["src"]
            article = div.a["href"]
            hashed = hash_string(title)
            vid = getVideo(article, title)
            if vid != None:
                newCache[hashed] = {"title": title, "imgHREF": image, "imageSize": "l", "articleHREF": article, "videoHREF":  vid}

    def getMImages(self, newCache):
        mDivs = self.soup.find_all("a", {"class": "m-preview-image"})
        for div in mDivs: 
            title = div["ms.title"]
            image = div.img["src"]
            article = div["href"]
            hashed = hash_string(title)
            vid = getVideo(article, title)
            if vid != None:
                newCache[hashed] = {"title": title, "imgHREF": image, "imageSize": "m", "articleHREF": article, "videoHREF":  vid}

def hash_string(string):
    return hashlib.sha256(string.encode('utf-8')).hexdigest()

def getVideo(article, title):
    vidFromArticle = getVideoFromArticle(article)
    if vidFromArticle != None:
        return vidFromArticle
    else:
        return getVideoFromAzure(title)

def checkDifference(newC, prevC):
    if newC == None or prevC == None:
        return True
    if len(newC) != len(prevC):
        return True
    else:
        for key in newC:
            if not key in prevC:
                return True
    return False

if __name__ == "__main__":
    Parser().getParsedInfo(dict())