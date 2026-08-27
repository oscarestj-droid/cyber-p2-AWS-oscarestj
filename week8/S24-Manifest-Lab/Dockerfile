# SABOTAGE: Using a severely outdated base image loaded with CVEs  
FROM nginx:1.14  

COPY index.html /usr/share/nginx/html/  

EXPOSE 80  
CMD ["nginx", "-g", "daemon off;"]  
