# Apaxy

Apaxy is a customisable theme built to enhance the experience of browsing web directories. It uses the `mod_autoindex` Apache module—and some CSS—to override the default style of a directory listing.

## Features

Apaxy may be basic, but it gives you a great deal of creative freedom when styling your directory.

* Style your directory listing with CSS.
* Make it pop with Javascript or jQuery.
* Add welcome messages, download instructions or copyright notices.
* Add custom mime type icons (requires editing the `.htaccess` file)

_Sadly, visual style is all you can work with. It's not possible to alter the generated table structure of the listing directory with Apaxy._

## Installation

Apaxy requires an Apache(2.2.11+) enabled HTTP server.

Let's assume you have a folder named `share` in your server root directory (the path thus being `http://mywebsite.com/share`) that you'd like to use as your listing directory:

* [Download](https://github.com/AdamWhitcroft/Apaxy/archive/master.zip) and unzip Apaxy
* Copy and paste the contents of the `/apaxy` folder to your `/share` folder.
* Rename `htaccess.txt` to `.htaccess` in both the `/share` and `/share/theme` folders.
* [Treat yo'self](http://25.media.tumblr.com/tumblr_lw7q28y0Mz1qanm80o1_500.gif), you're done.

## Docker images

A [local Demo](http://localhost:8080) can be started with docker.
`docker-compose build`
`docker-compose up`


## Apaxy themes

If you'd like to alter the default Apaxy theme, look in the `/theme` folder and you'll find the following files:

* `header.html`
* `footer.html`
* `style.css`

Edit these as you would any other HTML or CSS file.

Adding your own icons is a little more involved. You'll need to edit the main Apaxy `.htaccess` file. Look for the following as an example:

    AddIcon theme/icons/gif.png .gif

The above rule will assign an icon named `gif.png` from the directory `theme/icons/` to any file with the `.gif` extension.

This URL path is relative to your site's root.

## Mime Types

The default Apaxy theme `theme/apaxy` has icons in place for the following mime types:

    .ace .aif .aif .asf .asx .atom .avi .bin .c .cb7 .cba .cbt .cbr .cbz .class
    .command .cso .css .csv .dmg .doc .docm .docx .dot .dotm .eot .eps .f4a .f4b
    .fla .flv .gif .htm .html .ico .iso .iff .jar .java .jpeg .jpg .js .json
    .key .kth .log .m3u .m4a .make .markdown .md .mid .mov .mp2 .mp3 .mp4 .mpa
    .mpg .msg .mwa .numbers .odp .odt .ofm .otf .opus .pages .pdf .php3 .php4
    .php5 .php7 .php .phps .phtml .pkg .png .pot .potm .potx .pps .ppsm .ppsx
    .ppt .pptx .pptm .ps .psd .py .pyc .qt .ra .rar .rb .rm .rss .rtf .shtml
    .sql .srt .swf .tex .tif .tiff .ttf .txt .url .vob .wav .wma .wmv .woff
    .woff2 .wpd .wps .xfl .xhtml .xlam .xlr .xls .xlsb .xlsm .xlsx .xltm .xltx
    .xml .zip

## Troubleshooting

Make sure the options set in `.htaccess` files of Apaxy can actually be changed. This means that you need to allow to ovveride the used options in your apache configuration of the directory apaxy used with: `AllowOverride Indexes`

Find more information in the in the [apache documentation](https://httpd.apache.org/docs/2.2/de/mod/core.html).

## Credits

Apaxy owes its existence to the amazing [h5ai](http://larsjung.de/h5ai/) by [Lars Jung](https://twitter.com/lrsjng). Had I not seen this, I would never have looked into making my own (probably way less useful) version.

[Faenza Icons](http://tiheum.deviantart.com/art/Faenza-Icons-173323228) are used in the `apaxy` theme.
