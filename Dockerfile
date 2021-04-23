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
RUN for file_extension in 3dml 3ds 3g2 3gp 7z aac adp ai aif aifc aiff apk appcache asf asm asx atom au avi azw bat bin bmp bpk btif bz bz2 c cab caf cb7 cba cbr cbt cbz cc cgm class cmx com conf cpp css csv curl cxx dcurl deb def deploy dic diff dist distz djv djvu dll dmg dms doc docx dot dra dsc dtd dts dtshd dump dvb dwg dxf ecelp4800 ecelp7470 ecelp9600 elc eol eps epub etx exe f f4v f77 f90 fbs fh fh4 fh5 fh7 fhc flac fli flv flx fly for fpx fst fvt g3 gif gv gz gzip h h261 h263 h264 hh hpp htm html ico ics ief ifb in iso jad jar java jpe jpeg jpg jpgm jpgv jpm js json kar ktx latex list log lrf lvp m1v m2a m2v m3a m3u m3u8 m4a m4u m4v Makefile man mar markdown mcurl md mdb mdi me mid midi mj2 mjp2 mk3d mka mks mkv mmr mng mobi mov movie mp2 mp2a mp3 mp4 mp4a mp4v mpe mpeg mpg mpg4 mpga mpkg ms msi mxu n3 nfo npx odb odc odf odft odg odi odm odp ods odt oga ogg ogv opml otc otf otg oth oti otp ots ott p pas patch pbm pct pcx pdf pgm php phtml pic pkg pls png pnm pot ppm pps ppsx ppt pptx prc ps psd py pya pyv qt ra ram rar ras rb README rgb rip rlc rmi rmp roff rpm rss rtf rtx s s3m sass scss scurl sfv sgi sgm sgml sh sid sil smv snd so spot spx sql sub svg svgz t tar tex text tga tif tiff torrent tr tsv ttc ttf ttl txt udeb uri uris urls uu uva uvg uvh uvi uvm uvp uvs uvu uvv uvva uvvg uvvh uvvi uvvm uvvp uvvs uvvu uvvv vcard vcf vcs viv vob wav wax wbmp wdp weba webm webp wm wma wml wmls wmv wmx woff woff2 wvx xbm xcf xht xhtml xif xla xlc xlm xls xlsx xlt xlw xm xml xpm xwd xsl zip; do touch example.${file_extension}; done
RUN touch README

# allow user 'me' to read apache's files
RUN chown -R me:root /usr/local/apache2/ && \
    chmod -R g+rwX /usr/local/apache2/

# start container as me
USER me
