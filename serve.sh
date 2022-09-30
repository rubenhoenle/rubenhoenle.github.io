docker rm -f githubpages
docker run --name githubpages --volume="$PWD:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll:3.8 jekyll serve --watch --drafts
