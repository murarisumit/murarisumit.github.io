serve_with_drafts:
	jekyll serve --drafts

serve:
	jekyll serve

create:
	octopress new draft "$(name)"

publish:
	octopress publish "$(path)"
