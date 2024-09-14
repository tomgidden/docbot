---
date:
  month: September
  year: 2024
authors:
- firstname: Tom
  surname: Gidden
  email: tom@gidden.net
extraclass: no_wide no_wide_pre shade_monospace shade_pre shade_code strong_monospace no_narrow_monospace
...

# _docbot_, a Markdown to PDF converter

## Introduction

A Markdown to PDF converter using:
- _[Docker](https://docker.com)_ - a containerization engine
- _[Pandoc](https://pandoc.org)_ - a document format converter
- _[PagedJS](https://pagedjs.org)_ - an library for paginating HTML
- _[Chromium](https://www.chromium.org)_ - a PDF renderer ;)
- some CSS, fonts, and some minor glue scripts.

It's not rocket science, but it's fiddly and usually not worth spending the time to assemble into a single utility.  That's what this is for.

**Note:** This utility is unrelated to any other project called `docbot`; I created an unreleased utility using DocBook to PDF via XSL-FO 15 years earlier and previously in various forms back to 2000, and historically just called them `docbot` or similar.

## Usage

The utility is packaged as a Docker image, 