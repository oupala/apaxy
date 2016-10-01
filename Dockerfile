FROM php:7.0-apache
MAINTAINER Inti Gabriel <inti.gabriel+github@intigabriel.de>

RUN a2enmod rewrite
ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 APACHE_LOCK_DIR=/var/lock/apache2 APACHE_PID_FILE=/var/run/apache2.pid

COPY apache-config.conf /etc/apache2/sites-enabled/000-default.conf
COPY apaxy/ /var/www/html/
RUN mv /var/www/html/htaccess.txt /var/www/html/.htaccess && \
mv /var/www/html/theme/htaccess.txt /var/www/html/theme/.htaccess && \
rm -f /var/www/html/index.html && \
touch /var/www/html/example.gif && \
touch /var/www/html/example.jpg && \
touch /var/www/html/example.txt && \
touch /var/www/html/example.md && \
touch /var/www/html/example && \
touch /var/www/html/example.mp4 && \
touch /var/www/html/example.zip && \
touch /var/www/html/example.doc && \
touch /var/www/html/example.xls && \
touch /var/www/html/example.pdf && \
touch /var/www/html/example.tex && \
touch /var/www/html/example.c && \
touch /var/www/html/example.mp3

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
