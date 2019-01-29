# Server

This folder holds the Server codebase for NewsAR application.

## Instructions

### Local deployment

#### To update requirements.txt

* Install **pipreqs** using `pip install pipreqs`

```bash
cd ..
pipreqs ./server
```

#### To run locally

* Run `python main.py`

#### To test individual modules

* Run `python <module>.py`

### Docker and Azure deployments

#### To build and run docker container

* Run `docker build -t news-ar-server:latest .` to build the image

* Run `docker run -d --name news-ar-server -p 5000:5000 news-ar-server` to run the container

#### To deploy image to Azure Web App for Container Service

* Follow this [tutorial](https://blog.akquinet.de/2018/06/13/how-to-deploy-a-dockerized-app-to-microsoft-azure-web-app-for-containers/)

### Endpoints

This API exposes a single endpoint, `GET /cache` which returns the cached JSON containing the mapping
from image to video and additional information. The first hit to this endpoint can take upto 30 sec since it doesn't automatically populate
cache on startup.


Tested with news.microsoft.com/en-ca version only for Chrome on Safari!