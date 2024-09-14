TAG=ghcr.io/tomgidden/docbot

PDFS=$(patsubst %.md,%.pdf,$(wildcard *.md))

all: $(PDFS)

%.pdf: %.md
	docker run --rm --init -i \
		$(TAG) \
		./md2pdf.sh \
		< $< > $@

#		-v ./md2pdf.sh:/home/node/md2pdf.sh \
#		-v ./doc:/home/node/doc \
#.INTERMEDIATE: $(XMLS) $(FOS)

build:
	docker build -t $(TAG) .

push:
	docker push $(TAG)
