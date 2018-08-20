
## Deployment

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/revskill10/es-sinatra)

## Create schemas:

```
heroku run bundle exec db:init
```

## Release:

```
heroku run bundle exec sequent:migrate:online
heroku run bundle exec sequent:migrate:offline
```