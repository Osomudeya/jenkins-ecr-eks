FROM ubuntu:latest
RUN sudo apt update -y
RUN sudo apt install -y httpd
COPY ./index.html /var/www/html/index.html
EXPOSE 80
WORKDIR /var/www/html
CMD ["httpd","-D","FOREGROUND"]
