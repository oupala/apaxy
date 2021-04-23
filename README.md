# Apaxy

apaxy is a customisable theme built to enhance the experience of browsing web directories. It uses the `mod_autoindex` Apache module - and some css - to override the default style of a directory listing.

## Table of contents

- [features](#features)
- [installation](#installation)
- [docker image](#docker-image)
- [apaxy themes](#apaxy-themes)
- [media types](#media-types)
- [gallery](#gallery)
- [troubleshooting](#troubleshooting)
- [credits](#credits)

## Features

Apaxy may be basic, but it gives you a great deal of creative freedom when styling your directory.

- style your directory listing with css
- make it pop with javascript
- add welcome messages, download instructions or copyright notices
- add custom media type icons (requires editing the `.htaccess` file)
- use custom error pages

*Sadly, visual style is all you can work with. It's not possible to alter the generated table structure of the listing directory with Apaxy.*

## Installation

apaxy requires an apache (2.2.11+) enabled http server.

### Quick start

If you would like, you can automate the installation of Apaxy with the included `apaxy-configure.sh` script.

To get started, first open `apaxy.config` in your favorite editor, then edit the `apacheWebRootPath` and `installWebPath` variables to correspond to your server's settings. Save the file and exit.

You can set some parameters of `apaxy.config` on the command line instead of the config file. You can see the documentation of the cli with the following command: `apaxy-configure.sh -h`.

Then run the configuration script as a user that can write to the `installWebPath` directory. With apache under debian, this would be the `www-data` user:

```bash
$ sudo -u www-data ./apaxy-configure.sh
```

The files will be copied to the web server directory, and modified automatically based on the settings specified.

### Manual install

Let's assume you have a folder named `share` in your server root directory (the path thus being `http://mywebsite.com/share`) that you'd like to use as your listing directory:

- [download](https://github.com/oupala/apaxy/archive/master.zip) and unzip apaxy
- copy and paste the contents of the `/apaxy` folder to your `/share` folder
- edit `htaccess.txt` (now in the `/share` folder) and update all instances of paths marked with *{FOLDERNAME}* to point to your site root

So...

```apache
AddIconByType (gif,{FOLDERNAME}/theme/icons/gif.png) image/gif
```

Should be changed to...

```apache
AddIconByType (gif,/share/theme/icons/gif.png) image/gif
```

- if you want to enable the [gallery](#gallery) feature, overwrite the header and footer files:

```bash
mv footer-lightgallery.html footer.html
mv header-lightgallery.html header.html
```

- edit `footer.html`, along with all the other `html` documents (in the `/share/theme` folder) and update all instances of paths marked with *{FOLDERNAME}* to point to your site root

So...

```html
<script src={FOLDERNAME}/theme/apaxy.js></script>
```

Should be changed to...

```html
<script src=/share/theme/apaxy.js></script>
```

- once done, rename `htaccess.txt` to `.htaccess` in the `/share` directory
- [treat yo'self](http://25.media.tumblr.com/tumblr_lw7q28y0Mz1qanm80o1_500.gif), you're done!

## Docker image

A [local Demo](http://localhost:8080) can be started with docker.

```bash
docker-compose up
```

## Apaxy themes

If you'd like to alter the default Apaxy theme, look in the `/theme` folder and you'll find the following files:

- `header.html`
- `footer.html`
- `style.css`

Edit these as you would any other html or css file.

Adding your own icons is a little more involved. You'll need to edit the main Apaxy `.htaccess` file. Look for the following as an example:

```apache
AddIconByType (gif,{FOLDERNAME}/theme/icons/gif.png) image/gif
```

The above rule will assign an icon named `gif.png` from the directory `{FOLDERNAME}/theme/icons/` to any file whose media type is `image/gif`.

This url path is relative to your site's root.

## Media types

The default apaxy theme `/themes/apaxy` has icons in place for the following media types:

3dml 3ds 3g2 3gp 7z aac adp ai aif aifc aiff apk appcache asf asm asx atom au avi azw bat bin bmp bpk btif bz bz2 c cab caf cb7 cba cbr cbt cbz cc cgm class cmx com conf cpp css csv curl cxx dcurl deb def deploy dic diff dist distz djv djvu dll dmg dms doc docx dot dra dsc dtd dts dtshd dump dvb dwg dxf ecelp4800 ecelp7470 ecelp9600 elc eol eps epub etx exe f f4v f77 f90 fbs fh fh4 fh5 fh7 fhc flac fli flv flx fly for fpx fst fvt g3 gif gv gz gzip h h261 h263 h264 hh hpp htm html ico ics ief ifb in iso jad jar java jpe jpeg jpg jpgm jpgv jpm js json kar ktx latex list log lrf lvp m1v m2a m2v m3a m3u m3u8 m4a m4u m4v Makefile man mar markdown mcurl md mdb mdi me mid midi mj2 mjp2 mk3d mka mks mkv mmr mng mobi mov movie mp2 mp2a mp3 mp4 mp4a mp4v mpe mpeg mpg mpg4 mpga mpkg ms msi mxu n3 nfo npx odb odc odf odft odg odi odm odp ods odt oga ogg ogv opml otc otf otg oth oti otp ots ott p pas patch pbm pct pcx pdf pgm php phtml pic pkg pls png pnm pot ppm pps ppsx ppt pptx prc ps psd py pya pyv qt ra ram rar ras rb README rgb rip rlc rmi rmp roff rpm rss rtf rtx s s3m sass scss scurl sfv sgi sgm sgml sh sid sil smv snd so spot spx sql sub svg svgz t tar tex text tga tif tiff torrent tr tsv ttc ttf ttl txt udeb uri uris urls uu uva uvg uvh uvi uvm uvp uvs uvu uvv uvva uvvg uvvh uvvi uvvm uvvp uvvs uvvu uvvv vcard vcf vcs viv vob wav wax wbmp wdp weba webm webp wm wma wml wmls wmv wmx woff woff2 wvx xbm xht xhtml xif xla xlc xlm xls xlsx xlt xlw xm xml xpmxwd xsl zip

## Gallery

You can enable a gallery feature on apaxy. This feature is based on [lightgallery.js](https://sachinchoolur.github.io/lightgallery.js/).

See [installation](#installation) section for more information.

## Troubleshooting

Make sure the options set in `.htaccess` files of Apaxy can actually be changed. This means that you need to allow to override the used options in your apache configuration of the directory apaxy used with: `AllowOverride Indexes`.

Find more information in the in the [apache documentation](https://httpd.apache.org/docs/current/mod/core.html#allowoverride).

## Credits

apaxy owes its existence to the amazing [h5ai](http://larsjung.de/h5ai/) by [Lars Jung](https://twitter.com/lrsjng). Had I not seen this, I would never have looked into making my own (probably way less useful) version.

[Faenza icons](http://tiheum.deviantart.com/art/Faenza-Icons-173323228) are used in the `apaxy` theme. [Faenza icon theme](https://code.google.com/archive/p/faenza-icon-theme/) has been released under GPLv3 licence.

## Licence

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

