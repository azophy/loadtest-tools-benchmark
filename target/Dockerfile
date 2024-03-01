# syntax=docker/dockerfile:1

# Build the application from source
FROM golang:1.21-alpine AS build-stage

WORKDIR /web

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /app

# Run the tests in the container
#FROM build-stage AS run-test-stage
#RUN go test -v ./...

# Deploy the application binary into a lean image
FROM alpine AS build-release-stage

WORKDIR /

COPY --from=build-stage /app /app

EXPOSE 3000

ENTRYPOINT ["/app"]
