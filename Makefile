.SILENT:
.PHONY: serve

serve:
	bundle exec jekyll serve

build:
	JEKYLL_ENV=production bundle exec jekyll build
