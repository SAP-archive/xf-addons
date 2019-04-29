GIT_TAG=$(PULL_BASE_REF)
GIT_REPO=$(REPO_OWNER)/$(REPO_NAME)
PWD = $(shell pwd)

.PHONY: check
check:
	docker run -v $(PWD):/project dtzar/helm-kubectl:2.13.1 /bin/sh -c "cd /project && ./scripts/check-assets.sh"

.PHONY: prepare
prepare:
	docker run -v $(PWD):/project golang:1.12 /bin/sh -c "go get github.com/russross/blackfriday-tool && cd /project && ./scripts/prepare-assets.sh"

.PHONY: upload
upload:
	docker run -v ${PWD}:/project google/cloud-sdk:242.0.0-alpine /bin/sh -c "cd /project && ./scripts/upload-assets.sh $(UPLOAD)"