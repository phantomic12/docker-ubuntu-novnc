# Ubuntu 20.04LTS headless noVNC
# Connect to http://localhost:6080/
docker run --rm -d -p 6080:80 -v $PWD:/workspace:rw -e USER=student -e PASSWORD=centralesupelec -e RESOLUTION=1680x1050 --name ubuntu-novnc fredblgr/ubuntu-novnc:20.04
open -a firefox http://localhost:6080