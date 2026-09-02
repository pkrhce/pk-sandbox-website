# Use the official NGINX lightweight image
FROM nginx:alpine

# Copy our website code into the NGINX web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
