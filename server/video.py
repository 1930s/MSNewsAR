from bs4 import BeautifulSoup
import requests
import json

from azure.cognitiveservices.search.entitysearch import EntitySearchAPI
from azure.cognitiveservices.search.videosearch import VideoSearchAPI
from azure.cognitiveservices.search.videosearch.models import SafeSearch
from msrest.authentication import CognitiveServicesCredentials

HEADERS = {
    'User-Agent': 'My User Agent 1.0',
    'From': 'user@domain.com'
}

subscription_key_entity = None
subscription_key_video = None

with open("secrets/keys.json") as f:
    loaded = json.load(f)
    subscription_key_entity = loaded["entity"]["KEY1"]
    subscription_key_video = loaded["video"]["KEY1"]

def getVideoFromArticle(uri):
    soup = BeautifulSoup(requests.get(uri, headers=HEADERS).text, 'html.parser')
    video = soup.find("iframe", {"class": "youtube-player"})
    if video != None:
        return video["src"]
    return None
    
def getVideoFromAzure(title):
    entity_client = EntitySearchAPI(CognitiveServicesCredentials(subscription_key_entity))
    video_client = VideoSearchAPI(CognitiveServicesCredentials(subscription_key_video))

    try:
        entity_data = entity_client.entities.search(query=title)

        if entity_data.entities is not None:
            main_entities = [entity for entity in entity_data.entities.value
                             if entity.entity_presentation_info.entity_scenario == "DominantEntity"]
            if len(main_entities) != 0:
                video_result = video_client.videos.search(query=' '.join(str(ent) for ent in main_entities), safe_search=SafeSearch.strict)
                if video_result is not None and len(video_result.value) != 0:
                    soup = BeautifulSoup(video_result.value[0].embed_html, 'html.parser')
                    return soup.find("iframe")["src"]
        else:
            video_result = video_client.videos.search(query=title[:45], safe_search=SafeSearch.strict)
            if video_result is not None and len(video_result.value) != 0:
                soup = BeautifulSoup(video_result.value[0].embed_html, 'html.parser')
                return soup.find("iframe")["src"]

    except Exception as err:
        print("Encountered exception. {}".format(err))

    return None