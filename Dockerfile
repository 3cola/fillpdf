FROM meteorhacks/meteord:onbuild
MAINTAINER Etienne Colaitis <ecolaitis@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  pdftk

RUN npm install \
  atob \
  fdf

# Run as you wish!
# docker run -d --name fillpdf-db mongo
# docker run -d --link "fillpdf-db:db" -e "MONGO_URL=mongodb://db" \
#   -e "ROOT_URL=http://example.com" -p 7080:80 fillpdf
