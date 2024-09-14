TAG=tomgidden/docbot

PDFS=$(patsubst %.md,%.pdf,$(wildcard *.md))

all: $(PDFS)

ifdef DEBUG
DEBUGGING= \
	-v ./md2pdf.sh:/home/node/md2pdf.sh \
	-v ./tmp:/home/node/doc \
	-v ./assets:/home/node/assets
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
			./md2pdf.sh \
			> $@

build:
	docker build -t $(TAG) .

release: build
	docker push tomgidden/docbot