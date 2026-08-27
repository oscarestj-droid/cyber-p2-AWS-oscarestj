# Step 1: Use a minimal base image
FROM nginx:alpine

# Step 2: Copy the website files into the container
COPY index.html /usr/share/nginx/html/

# Step 3: Modify permissions so the non-root user can run the web server
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown -R nginx:nginx /var/cache/nginx

# Step 4: Explicitly drop root privileges and switch to the nginx user
USER nginx

# Step 5: Expose the port and start the server
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
