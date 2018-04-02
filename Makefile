serve-with-drafts:
	jekyll serve --drafts

serve:
	jekyll serve

create:
	octopress new draft "$(name)"

publish:
	octopress publish "$(path)"

push:
	git push	
