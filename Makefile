container-name="personal-blog"

serve-with-drafts:
	jekyll serve --drafts

serve:
	# docker run --rm --volume="$(shell pwd):/srv/jekyll" --env JEKYLL_ENV=development -p 3000:3000 jekyll/jekyll:4 jekyll serve --watch --incremental 
	docker run --name $(container-name) --rm --volume="$(shell pwd):/srv/jekyll" --env JEKYLL_ENV=development -p 3000:3000 jekyll/jekyll:4 jekyll serve --force_polling --incremental

stop:
	docker stop $(container-name)

push:
	git push	
