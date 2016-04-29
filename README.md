# FillPDF
A simple application to map and fill PDF Forms in bulk.

## How to run locally for debug
[meteor link](https://www.meteor.com)
> $ `meteor`

## How to build for docker
[docker link](https://www.docker.com)

[docker hub repository link](https://hub.docker.com/r/3cola/fillpdf/)

### 1: we build the meteor code
> $ `make build`

### 2: we build the docker image
> $ `make image`

take a look at the Makefile for more details...

## How to run in docker for staging for dev
> $ `docker-compose up -d`

or

> $ `docker run -d --name fillpdf-db 3cola/alpine-mongo`

and

> $ `docker run -d --name fillpdf-app --link=fillpdf-db:db -e MONGO_URL=mongodb://db -e ROOT_URL=http://localhost -p 80:8080 3cola/fillpdf`

## How to deploy for Production

create the db container with authentication on

> $ `docker run -d --name fillpdf-db 3cola/alpine-mongo --auth --storageEngine wiredTiger`

add the initial admin user

> $ `docker exec -it fillpdf-db mongo admin`

> \> `db.createUser({ user: "admin", pwd: "myPassw0rd", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })`

> $ `docker restart fillpdf-db`

add a dbuser for the app with a its own db

> $ `docker exec -it fillpdf-db bash`

> $ `mongo -u "admin" -p "myPassw0rd" --authenticationDatabase "admin" fillpdf`

> \> `db.createUser({ user: "fillpdf", pwd: "123Soleil", roles: [ { role: "dbOwner", db: "fillpdf" } ] })`

and run the app container

> $ `docker run -d --link "fillpdf-db:db" -e "MONGO_URL=mongodb://fillpdf:123Soleil@db/fillpdf" -e "ROOT_URL=http://example.com" -e "MAIL_URL=smtp://user:password@smtpsrv:port" -p 80:8080 --name fillpdf 3cola/fillpdf`

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
