.PHONY: build check run save

# Default values for variables
REPO  ?= fredblgr/
NAME  ?= ubuntu-novnc
TAG   ?= 20.04

# These files will be generated from teh Jinja templates (.j2 sources)
templates = Dockerfile rootfs/etc/supervisor/conf.d/supervisord.conf

# Rebuild the container image and remove intermediary images
build: $(templates)
	docker build -t $(REPO)$(NAME):$(TAG) .
	docker rmi $$(docker images --filter "dangling=true" -q)
	
# Test run the container
#  the local dir will be mounted under /src
check:
	echo "http://localhost:6080"
	docker run --rm \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e USER=student -e PASSWORD=CS3ASL \
		-e RESOLUTION=1680x1050 \
		--name $(NAME)-test \
		$(REPO)$(NAME):$(TAG)

run:
	echo "http://localhost:6080"
	docker run --rm -d \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e USER=student -e PASSWORD=CS3ASL \
		-e RESOLUTION=1680x1050 \
		--name $(NAME)-test \
		$(REPO)$(NAME):$(TAG)
	sleep 5
	open http://localhost:6080 || xdg-open http://localhost:6080 || echo "http://localhost:6080"

# Add option -e HTTP_PASSWORD=CS3ASL to control the access to the web page.
#  -p 6081:443

save:
	docker save $(REPO)$(NAME):$(TAG) | gzip > $(NAME)-$(TAG).tar.gz

# Connect inside the running container for debugging
shell:
	docker exec -it ubuntu-novnc-test bash

clean:
	docker rmi $(REPO)$(NAME):$(TAG)
	docker image prune -f
