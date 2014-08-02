TAGNAME = test-haproxy
DOCKER_FRAGMENTS = common/*.docker *.docker
TEMP_FILES = *~ 
CONTENT_DIR = etc templates

rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
ALL_TEMP_FILES :=  $(foreach d,$(CONTENT_DIR),$(call rwildcard,,$(TEMP_FILES)))
CONTENT_FILES := $(foreach d,$(CONTENT_DIR),$(call rwildcard,,*))
CONTENT_FILES := $(filter-out $(ALL_TEMP_FILES), $(CONTENT_FILES))

DOCKER_FRAGMENT_FILES := $(wildcard $(DOCKER_FRAGMENTS))


.phony: git-sub build clean tar test-it

Dockerfile: Dockerfile.docker $(DOCKER_FRAGMENT_FILES)
	@echo Generate Dockerfile
	@cp Dockerfile.docker Dockerfile
	@perl -pe 's/\$$IMPORT (.*)/`test -f $$1 && cat $$1`/ge' -i Dockerfile
	@sed '1s/^/\# Autogenerated - do not edit\n/' -i Dockerfile

build: Dockerfile
	docker build --tag $(TAGNAME) . 

$(TAGNAME).tar: Dockerfile build
	docker save -o $(TAGNAME).tar $(TAGNAME)

$(TAGNAME).tar.gz: $(TAGNAME).tar
	gzip $(TA

tar: $(TAGNAME).tar

clean:
	rm Dockerfile

git-sub:
	git submodule init
	git submodule update

test-it: 
	@echo $(DOCKER_FRAGMENT_FILES)
	@echo $(CONTENT_FILES)
