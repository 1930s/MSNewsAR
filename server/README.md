# Server

This folder holds the Server codebase for NewsAR application. 

#### To update requirements.txt

* Install **pipreqs** using `pip install pipreqs`
```
cd ..
pipreqs ./server
```

#### To run locally
* Run `python main.py`

#### To test individual modules
* Run `python <module>.py`

#### To build and run docker container
* Run `docker build -t news-ar-server:latest .` to build the image

* Run `docker run -d --name news-ar-server -p 5000:5000 news-ar-server` to run the container

#### To deploy image to Azure Container Service
TBD
