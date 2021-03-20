# Ubuntu 20.04LTS headless noVNC
# Connect to http://localhost:6080/
docker run --rm --detach \
  --publish 6080:80 \
  --volume $PWD:/workspace:rw \
  --env USERNAME=`id -n -u` --env USERID=`id -u` \
  --env RESOLUTION=1200x800 \
  --name ubuntu-novnc \
  fredblgr/ubuntu-novnc:20.04
sleep 4
open -a firefox http://localhost:6080