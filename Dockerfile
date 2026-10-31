FROM busybox:1.36
COPY www /www
USER 65534
EXPOSE 8080
CMD ["httpd", "-f", "-v", "-p", "8080", "-h", "/www"]
