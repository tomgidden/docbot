TAG=tomgidden/pdfulator

PDFS=$(patsubst %.md,%.pdf,$(wildcard *.md))

all: $(PDFS)

ifdef DEBUG
DEBUGGING= \
	-v ./entrypoint.sh:/entrypoint.sh \
	-v ./tmp:/tmp \
	-v ./assets:/assets
endif

%.pdf: %.md
	($(if $(wildcard $*.yaml),\
		echo "---" && cat $*.yaml && echo "\n..." && cat $*.md,\
		$(if $(wildcard $*.yml),\
			echo "---" && cat $*.yml && echo "\n..." && cat $*.md,\
			cat $*.md \
		) \
	)) | \
		docker run --rm --init -i \
			$(DEBUGGING) \
			$(TAG) \
			- > $@

watch:
	docker run --rm --init -i -t \
			$(DEBUGGING) \
			-v ./:/in \
			$(TAG) \
			--watch

build:
	docker build -t $(TAG) .

release:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag $(TAG) .

