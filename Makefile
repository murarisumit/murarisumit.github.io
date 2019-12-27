serve-with-drafts:
	jekyll serve --drafts

serve:
	docker-compose up
	# docker run --name $(container-name) --rm --volume="$(shell pwd):/srv/jekyll" --env JEKYLL_ENV=development -p 3000:3000 jekyll/jekyll:4 jekyll serve --force_polling --incremental

stop:
	docker-compose down

push:
	git push	
