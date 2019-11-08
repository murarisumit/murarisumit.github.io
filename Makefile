serve-with-drafts:
	jekyll serve --drafts

serve:
	docker run --rm --volume="$(shell PWD):/srv/jekyll" --env JEKYLL_ENV=development -p 3000:3000 jekyll/jekyll:4 jekyll serve

create:
	octopress new draft "$(name)"

publish:
	octopress publish "$(path)"

push:
	git push	
