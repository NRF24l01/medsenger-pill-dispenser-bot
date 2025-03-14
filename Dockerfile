# syntax=docker/dockerfile:1

ARG GOVERSION=1.24.1

FROM golang:${GOVERSION}-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /server

FROM alpine AS server
WORKDIR /
COPY --from=build /server /server
EXPOSE 8080
CMD ["/server"]
