VERSION = 1.0.0
IMAGE = 3cola/fillpdf

all: image publish

latest: image-latest publish-latest

image-latest:
	docker build -t $(IMAGE):latest --no-cache .

publish-latest:
	docker push $(IMAGE):latest

image:
	docker build -t $(IMAGE):$(VERSION) --no-cache .

publish:
	docker push $(IMAGE):$(VERSION)
