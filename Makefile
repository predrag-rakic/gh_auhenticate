

heroku.push:
	git push heroku master -f
	heroku logs -t
