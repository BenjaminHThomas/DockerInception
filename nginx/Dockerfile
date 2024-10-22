# Base Image
FROM nginx:alpine

# copy the custom index html file to nginx folder
COPY index.html /usr/share/nginx/html/

# Expose nginx port
EXPOSE 80

# Start nginx service
CMD ["nginx", "-g", "daemon off;"]
