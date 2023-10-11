# stage 1
FROM jekyll/jekyll:3.6.2 as jekyll

WORKDIR /srv/jekyll

COPY ./blog .

RUN jekyll build

# stage 2
FROM asciidoctor/docker-asciidoctor:latest as asciidoctor

#WORKDIR /asciidoc/src

#COPY ./asciidoc/mvbargau/konzertmeister.adoc /
#RUN asciidoctor konzertmeister.adoc

COPY ./asciidoc /asciidoc/src

WORKDIR /asciidoc

RUN ls -lisa /asciidoc/src
RUN asciidoctor -D output -R src ./**/*.adoc
# *.adoc

# stage 3
FROM nginx:latest as webserver

# copy jekyll sources
COPY --from=jekyll /srv/jekyll/_site /usr/share/nginx/html

# copy asciidoctor sources
COPY --from=asciidoctor /asciidoc/output /usr/share/nginx/html/docs
