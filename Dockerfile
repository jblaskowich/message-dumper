# Start from golang:alpine with the latest version of Go installed
# and use it as a build environment
FROM golang:alpine3.8

WORKDIR /go/src/github.com/jblaskowich/message-dumper/
# Copy the local code to the container
COPY . .

# build du code source
RUN CGO_ENABLED=0 GOOS=linux go build -v -o message-dumper

# Transfert the builded binary to scratch
# in order to have the smallest footprint
FROM scratch
COPY --from=0 /go/src/github.com/jblaskowich/message-dumper/message-dumper .

# Run the helloknative command when the container starts
ENTRYPOINT ["./message-dumper"]

# Document that the service listens on port 8080
EXPOSE 8080