# MSNewsAR

**Powered by Azure Cognitive Services and Web App for Containers**

news.microsoft.com with video as a supplement to images in AR. Dynamic parsing at backend to find related videos. Proof of concept at _NWHacks2019_. 

**Winner**, *Microsoft Best Azure Hack* and *Microsoft imagine cup 2019 semi-finalist*.

[![MSNewsAR](https://img.youtube.com/vi/ALl_-Kd7OM8/0.jpg)](https://www.youtube.com/watch?v=ALl_-Kd7OM8)

*Click the image above to watch a demo*

## Architecture

![Architecture](https://github.com/dandua98/MSNewsAR/blob/master/common/images/architecture.jpg)

*Architecture diagram drawn by [Mai Matsuhisa](https://github.com/MAIMAI728)*

The backend parses the webpage every 30 minutes and uses Azure entity search and video search APIs from
cognitive services to find relevant video content for the news articles. A sample of data returned by this API
can be found [here](https://github.com/dandua98/MSNewsAR/blob/master/server/cache/cache.json). This backend was initially
deployed on Azure Web App for Containers but we used a local cache of videos later for demos due to the video loading from internet
on ARScene being very low quality and our container deployment failing (our hackathon hack was hacky).

