docker-ubuntu-novnc
===================


Docker image to provide HTML5 VNC interface to access a Ubuntu 20.04 LXDE desktop environment.

Based on the work by [Doro Wu](https://github.com/fcwu), see on [Docker](https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/)

Typical usage is:
docker run --rm -d -p 6080:80 -v $PWD:/workspace:rw -e USER=username -e PASSWORD=password -e RESOLUTION=1680x1050 --name ubuntu-novnc fredblgr/ubuntu-novnc:20.04

Quick Start
-------------------------

Run the docker container and access with port `6080`

```
docker run -p 6080:80 fredblgr/ubuntu-novnc:20.04
```

Browse http://127.0.0.1:6080/


VNC Viewer
------------------

Forward VNC service port 5900 to host by

```
docker run -p 6080:80 -p 5900:5900 fredblgr/ubuntu-novnc:20.04
```

Now, open the vnc viewer and connect to port 5900. If you would like to protect vnc service by password, set environment variable `VNC_PASSWORD`, for example

```
docker run -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword fredblgr/ubuntu-novnc:20.04
```

A prompt will ask password either in the browser or vnc viewer.

HTTP Base Authentication
---------------------------

This image provides base access authentication of HTTP via `HTTP_PASSWORD`

```
docker run -p 6080:80 -e HTTP_PASSWORD=mypassword fredblgr/ubuntu-novnc:20.04
```

SSL
--------------------

To connect with SSL, generate self signed SSL certificate first if you don't have it

```
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt
```

Specify SSL port by `SSL_PORT`, certificate path to `/etc/nginx/ssl`, and forward it to 6081

```
docker run -p 6081:443 -e SSL_PORT=443 -v ${PWD}/ssl:/etc/nginx/ssl fredblgr/ubuntu-novnc:20.04
```

Screen Resolution
------------------

The Resolution of virtual desktop adapts browser window size when first connecting the server. You may choose a fixed resolution by passing `RESOLUTION` environment variable, for example

```
docker run -p 6080:80 -e RESOLUTION=1920x1080 fredblgr/ubuntu-novnc:20.04
```

Default Desktop User
--------------------

The default user is `root`. You may change the user and password respectively by `USER` and `PASSWORD` environment variable, for example,

```
docker run -p 6080:80 -e USER=name -e PASSWORD=password fredblgr/ubuntu-novnc:20.04
```

Deploy to a subdirectory (relative url root)
--------------------------------------------

You may deploy this application to a subdirectory, for example `/some-prefix/`. You then can access application by `http://127.0.0.1:6080/some-prefix/`. This can be specified using the `RELATIVE_URL_ROOT` configuration option like this

```
docker run -p 6080:80 -e RELATIVE_URL_ROOT=some-prefix fredblgr/ubuntu-novnc:20.04
```

NOTE: this variable should not have any leading and trailing slash (/)


License
==================

Apache License Version 2.0, January 2004 http://www.apache.org/licenses/LICENSE-2.0

Original work by [Doro Wu](https://github.com/fcwu)

Adapted by [Frédéric Boulanger](https://github.com/Frederic-Boulanger-UPS)
