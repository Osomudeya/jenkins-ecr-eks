FROM ubuntu:latest
RUN  apt update -y
RUN apt install -y apache2
COPY ./index.html /var/www/html/index.html
EXPOSE 80
WORKDIR /var/www/html
CMD ["httpd","-D","FOREGROUND"]
