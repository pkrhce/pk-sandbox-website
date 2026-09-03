# STAGE 1: The "Builder"
# We use a heavy image with tools (like curl and bash) to prepare our website
FROM alpine:latest AS builder
WORKDIR /app
# Simulate a "build" process by generating an index.html file dynamically
RUN echo "<h1>Built using a Multi-Stage Dockerfile! 🏗️</h1>" > index.html
RUN echo "<p>This is much more secure and lightweight.</p>" >> index.html

# STAGE 2: The "Production" Image
# We use a tiny, secure NGINX image
FROM nginx:alpine
# We ONLY copy the finished index.html from STAGE 1. 
# The heavy alpine builder image is thrown away!
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html
EXPOSE 80
