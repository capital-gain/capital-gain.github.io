.SILENT:
.PHONY: serve build

serve:
	bundle exec jekyll serve --drafts --future

build:
	JEKYLL_ENV=production bundle exec jekyll build
