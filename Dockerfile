FROM golang:alpine as tools

RUN apk update
RUN apk add git
RUN go get github.com/subfuzion/envtpl/...

FROM alpine:3.7

ENV MYSQL_USER "root"
ENV MYSQL_PASSWORD ""

ENV VERBOSE false

COPY --from=tools /go/bin/envtpl /usr/local/bin/
RUN apk update
RUN apk add mysql-client
ADD entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]