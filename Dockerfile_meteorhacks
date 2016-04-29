FROM meteorhacks/meteord:onbuild
MAINTAINER Etienne Colaitis <ecolaitis@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  pdftk
RUN mkdir -p /cfs
VOLUME /cfs

# Prepare the db for dev:
# docker run -d --name fillpdf-db mongo
# or for prod:
# docker run -d --name fillpdf-db mongo --auth --storageEngine wiredTiger
# add the initial admin user
# docker exec -it fillpdf-db bash
# mongo admin
# > db.createUser({ user: "admin", pwd: "myPassw0rd", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })
# mongod --shutdown
# docker start fillpdf-db
# add a user for the app with its own db
# mongo -u "admin" -p "myPassw0rd" --authenticationDatabase "admin" fillpdf
# > db.createUser({ user: "fillpdf", pwd: "123Soleil", roles: [ { role: "dbOwner", db: "fillpdf" } ] })

# docker run -d --link "fillpdf-db:db" -e "MONGO_URL=mongodb://fillpdf:123Soleil@db/fillpdf" -e "ROOT_URL=http://example.com" -e "MAIL_URL=smtp://user:password@smtpsrv:port" -p 7080:80 --name fillpdf 3cola/fillpdf
