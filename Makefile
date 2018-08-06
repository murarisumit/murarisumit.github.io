serve-with-drafts:
	jekyll serve --drafts

serve: lessify
	jekyll serve

lessify:
	find static/css/src/ -name '*.less' -exec lessc {} \; > static/css/dist/main.css

watch-less:
	less-watch-compiler

create:
	octopress new draft "$(name)"

publish:
	octopress publish "$(path)"

push:
	git push	
