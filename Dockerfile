FROM php:7.3-apache
LABEL authors="Carlos Brandt <chbrandt@github>, Inti Gabriel <inti.gabriel+github@intigabriel.de>"

ARG HTDOCS=/var/www/html

ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data

RUN a2enmod rewrite

COPY apache-config.conf /etc/apache2/sites-enabled/000-default.conf

COPY apaxy/ $HTDOCS

RUN cd ${HTDOCS}                                            && \
    rm -f index.html                                        && \
    sed -i "s:/{FOLDERNAME}::g" htaccess.txt                && \
    sed -i "s:/{FOLDERNAME}::g" theme/htaccess.txt          && \
    grep -l "{FOLDERNAME}" theme/*.html | xargs -L1 -I {}   \
        sed -i "s:/{FOLDERNAME}::g" {}                      && \
    mv htaccess.txt .htaccess                               && \
    mv theme/htaccess.txt theme/.htaccess


RUN ["/bin/bash", "-c", \
    "cd $HTDOCS && touch example.{gif,jpg,txt,md,mp4,zip,doc,xls,pdf,tex,c,mp3}"]

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
