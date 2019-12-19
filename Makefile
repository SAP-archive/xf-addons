PWD = $(shell pwd)

.PHONY: validate
check:
	docker run -v $(PWD):/project dtzar/helm-kubectl:2.13.1 /bin/sh -c "cd /project && ./scripts/validate.sh"
