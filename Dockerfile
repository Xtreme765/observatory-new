# Dockerfile for Observatory-new

# This takes advantage of multi-stage Docker builds to first compile and
# bundle Observatory-new and then create a Docker image containing only
# the necessary components.

# Instructions on deploying this Docker image are in SETUP.md

# --- Docker Build Stage 1 ---

# Uses the official rust nightly builder
FROM rustlang/rust:nightly as builder

# Copy in all the source files and switch to it
COPY . /build/
WORKDIR /build/

# Build the project in release mode
RUN cargo build --release

# Strip debug symbols out of binary
RUN strip /build/target/release/observatory

# --- Docker Build Stage 2 ---

# Use Debian Slim for it's small footprint.
FROM debian:stable-slim

# Set the workdir
WORKDIR /

# Install OpenSSL
RUN apt-get -qq update && apt-get -qq install openssl -y 

# Create a new user
RUN useradd -md /home/observatory -r observatory

# Create the user's home folder and move to it
WORKDIR /home/observatory

# Create the folder that the database will be in
RUN mkdir -p /var/lib/observatory

# Change the owner of the database folder
RUN chown -R observatory /var/lib/observatory/

# Switch to the user
USER observatory

# Copy in the binary from the builder
COPY --from=builder /build/target/release/observatory .

# Expose the HTTP port
EXPOSE 8000

# Run Observatory
CMD ./observatory
