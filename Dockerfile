FROM ubuntu:latest

RUN apt update -y && apt install -y apache2

COPY index.html /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]

