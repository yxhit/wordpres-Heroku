# XRay Heroku

## 概述

用于在 Heroku 上部署 XRay Websocket。

**Heroku 为我们提供了免费的容器服务，我们不应该滥用它，所以本项目不宜做为长期翻墙使用。**

在这里感谢bclswl0827提供的v2ray教程。

## 镜像

本镜像不会因为大量占用资源而被封号。

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https%3A%2F%2Fgithub.com%2Fyxhit%2FXray-Heroku)

### UUID

`UUID` > `一个 UUID，供用户连接时验证身份使用`。

XRay 将在部署时不会自动安装最新版本，目前是1.1.4版。

**出于安全考量，除非使用 CDN，否则请不要使用自定义域名，而使用 Heroku 分配的二级域名，以实现 XRay Websocket + TLS。**
