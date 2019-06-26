FROM python:3.7-alpine as base
FROM base as builder

RUN mkdir /install
WORKDIR /install
RUN apk update && apk add gcc libc-dev
RUN pip install --install-option="--prefix=/install" parsedmarc

FROM base
ENV TZ=Europe/Madrid
RUN apk add libmaxminddb
COPY --from=builder /install /usr/local
COPY parsedmarc.ini /etc/parsedmarc.ini
CMD [ "parsedmarc", "-c", "/etc/parsedmarc.ini" ]