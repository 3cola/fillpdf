VERSION = 1.0.2
IMAGE = 3cola/fillpdf

build:
	meteor build .build/ --directory --server-only --architecture=os.linux.x86_64

build-tarball:
	meteor build .build/ --server-only --architecture=os.linux.x86_64

latest: image-latest publish-latest

image-latest:
	docker build -t $(IMAGE):latest --no-cache ./.build

publish-latest:
	docker push $(IMAGE):latest

image:
	docker build -t $(IMAGE):$(VERSION) ./.build

publish:
	docker push $(IMAGE):$(VERSION)
