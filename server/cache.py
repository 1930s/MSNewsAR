import json 
import time
from parser import Parser

class Cacher:

    def __init__(self):
        self.lastUpdated = 0
        self.previousCache = None
        self.parser = Parser()
        
        self.setup()

    def setup(self):
        cacheFile = open('cache/cache.json')
        self.previousCache = json.load(cacheFile)

        self.getCache()

    def getCache(self):

        if self.previousCache != None and (time.time() - self.lastUpdated < 30 * 60 * 100): 
            return self.previousCache
        else:
            self.lastUpdated = int(time.time())

            isUpdated, updatedData = self.parser.getParsedInfo(self.previousCache)
            if isUpdated:
                self.previousCache["data"] = updatedData
                self.previousCache["_id"] = self.lastUpdated
                return self.previousCache
            else:
                return None

if __name__ == "__main__":
    print(Cacher().getCache())
        
