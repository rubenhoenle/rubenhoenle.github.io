# stage 1: jekyll 
FROM jekyll/jekyll:3.6.2 as jekyll
WORKDIR /srv/jekyll
COPY ./blog .
RUN jekyll build

# stage 2: asciidoctor
FROM asciidoctor/docker-asciidoctor:latest as asciidoctor
COPY ./asciidoc /asciidoc/src
WORKDIR /asciidoc
RUN asciidoctor -D output -R src ./**/*.adoc

# stage 3
FROM nginx:latest as webserver
# copy jekyll sources
COPY --from=jekyll /srv/jekyll/_site /usr/share/nginx/html
# copy asciidoctor sources
COPY --from=asciidoctor /asciidoc/output /usr/share/nginx/html/docs

