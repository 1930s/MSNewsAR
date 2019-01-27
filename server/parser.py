class Parser:

    def __init__(self):
        self.NEWS_URL = "https://news.microsoft.com/en-ca/"

    def getParsedInfo(self, previousCache):
        return True, previousCache["data"]