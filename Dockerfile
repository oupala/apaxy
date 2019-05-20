# bash docker image will be used for configuring apaxy
FROM bash

# set apaxyPath to the path where you want apaxy to be installed
# by default, apaxy will be available at "/" (web root)
ARG apaxyPath=""

# copy apaxy and proceed to configuration
WORKDIR /
COPY . /
RUN bash apaxy-configure.sh -w "${apaxyPath}"

# httpd docker image will be used for running apaxy
FROM httpd:2.4

# set apaxyPath to the path where you want apaxy to be installed
# by default, apaxy will be available at "/" (web root)
ARG apaxyPath=""

# image labels and description
LABEL name="apaxy" \
      description="Apaxy is a customisable theme built to enhance the experience of browsing web directories. It uses the mod_autoindex Apache module — and some CSS — to override the default style of a directory listing" \
      maintainer="Ploc" \
      url="https://oupala.github.io/apaxy/"

# remove index.html file from original httpd image
RUN rm /usr/local/apache2/htdocs/index.html

# enable apache config to be overridden by .htaccess files
RUN sed -i '/<Directory "\/usr\/local\/apache2\/htdocs">/,/<\/Directory>/ s/AllowOverride None/AllowOverride Options Indexes FileInfo/' /usr/local/apache2/conf/httpd.conf

# define apache listen port on a port greater than 1024 to allow a non-root user to start apache
RUN sed -i 's/Listen\ 80/Listen\ 8080/g' /usr/local/apache2/conf/httpd.conf
EXPOSE 8080

# create 'me' group whith gid 1000 and 'me' user in this group with uid 1000
# see https://docs.openshift.com/enterprise/3.2/creating_images/guidelines.html#use-uid
RUN groupadd -f -g 1000 me && \
    useradd -u 1000 -g me me

# copy apaxy directory
COPY --from=0 /var/www/html${apaxyPath} /usr/local/apache2/htdocs${apaxyPath}

WORKDIR /usr/local/apache2/htdocs${apaxyPath}
RUN for file_extension in txt mp3 mp4 7z bin bmp c xlsx iso cpp css dev docx svg ai exe gif h html ico jar jpg js md pdf php m3u png ps psd py rar rb rpm rss cmd sql tiff epub xml zip; do touch example.${file_extension}; done

# allow user 'me' to read apache's files
RUN chown -R me:root /usr/local/apache2/ && \
    chmod -R g+rwX /usr/local/apache2/

# start container as me
USER me
