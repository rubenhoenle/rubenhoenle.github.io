# stage 1
FROM asciidoctor/docker-asciidoctor:latest as asciidoctor

WORKDIR /

COPY konzertmeister.adoc /

RUN asciidoctor konzertmeister.adoc

# stage 2
FROM nginx:latest as webserver

COPY --from=asciidoctor /konzertmeister.html /usr/share/nginx/html/index.html
