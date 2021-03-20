#!/bin/sh
REPO=fredblgr/
IMAGE=ubuntu-novnc
TAG=20.04
URL=http://localhost:6080

docker run --rm -d \
		  -p 6080:80 \
		  -v ${PWD}:/workspace:rw \
		  -e USERNAME=`id -n -u` -e USERID=`id -u` -e PASSWORD=ubuntu \
		  -e RESOLUTION=1400x900 \
		  --name ${IMAGE}-run \
		  ${REPO}${IMAGE}:${TAG}
sleep 5

if command -v open 2>&1 /dev/null
then
  open ${URL}
elif command -v xdg-open 2>&1 /dev/null
then
  xdg-open "${URL}"
else
  echo "# Point your browser at ${URL}"
  echo "You may install xdg-utils so that I can do that for you."
fi
