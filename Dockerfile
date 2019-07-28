FROM cibuilds/hugo:0.55.6 as hugo

ENV HUGO_ENV production

WORKDIR /src
COPY . /src

RUN hugo -v

FROM nginx:stable-alpine

RUN rm -f /usr/share/nginx/html/index.html
COPY --from=hugo /src/public /usr/share/nginx/html
