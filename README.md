# PDFApp
A simple application to map and fill PDF Forms in bulk.

## How to run locally for debug
[meteor link](https://www.meteor.com)
> `meteor`

## How to build for docker
[docker link](https://www.docker.com)

[docker hub repository link](https://hub.docker.com/r/3cola/fillpdf/)

> `docker build -t 3cola/fillpdf .`

## How to run in docker
> `docker-compose up -d`

or

> `docker run -d --name fillpdf-db mongo`

and

> `docker run -d --name fillpdf-app --link=fillpdf-db:db -e MONGO_URL=mongodb://db -e ROOT_URL=http://localhost -p 80:80 3cola/fillpdf`

The first user created by default is
> mc@dm.in

with a default password
> password

## apt-get package used by this project
pdftk

## NPM packages used by this project
atob
fdf

## Meteor packages used by this project, one per line.
coffeescript
less
accounts-base
accounts-password
aldeed:autoform@5.1.2
aldeed:collection2
dburles:collection-helpers
matb33:collection-hooks
alanning:roles
aldeed:simple-schema
fortawesome:fontawesome
raix:handlebar-helpers
cfs:standard-packages
cfs:gridfs
aldeed:template-extension
yogiben:helpers
iron:router
yogiben:autoform-modals
yogiben:pretty-email
yogiben:autoform-file
multiply:iron-router-progress
manuelschoebel:ms-seo
spiderable
accounts-ui
jparker:gravatar
tap:i18n
useraccounts:bootstrap
juliancwirko:s-alert
juliancwirko:s-alert-stackslide
momentjs:moment
zimme:active-route
twbs:bootstrap
useraccounts:iron-routing
reywood:publish-composite
percolate:momentum-iron-router
percolate:momentum
natestrauser:animate-css
meteorhacks:subs-manager
fastclick
yogiben:admin
timmyg:wow
tsega:skrollr
meteor-base
mobile-experience
mongo
blaze-html-templates
session
jquery
tracker
logging
reload
random
ejson
spacebars
check
standard-minifier-css
standard-minifier-js
ramda:ramda
pdftk:pdftk
cfs:filesystem
udondan:jszip
