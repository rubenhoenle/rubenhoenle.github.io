# stage 1: asciidoctor
FROM docker.io/asciidoctor/docker-asciidoctor:latest as asciidoctor
COPY ./asciidoc /asciidoc/src
WORKDIR /asciidoc
RUN asciidoctor -D output -R src ./**/*.adoc

# stage 2
FROM docker.io/nginx:latest as webserver
# copy homepage sources
COPY homepage/index.html /usr/share/nginx/html/
COPY homepage/main.css /usr/share/nginx/html/
# copy asciidoctor sources
COPY --from=asciidoctor /asciidoc/output /usr/share/nginx/html/docs

