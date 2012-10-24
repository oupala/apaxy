#Apaxy

Apaxy is a simple, customisable theme for your Apache directory listing. Turn [this](http://bukk.it) into [this](http://adamwhitcroft.com/apaxy/demo).

##Installation

Apaxy is simple to install, all you need is a server running Apache and FTP access to the folder you'd like use.

* Download and unzip.
* Open the `/themes` folder and - from the theme you'd like to use - copy the `htaccess.txt` file and `/style` folder and drop them into the directory you'd like to use for your Apaxy listing.
* Open the `htaccess.txt` in the main folder and do a search and replace, substituting `{dir folder}` with the name of your Apaxy listing folder.
* Rename `htaccess.txt` to `.htaccess` in both the main and `/style` folder.
* [Treat yo'self](http://25.media.tumblr.com/tumblr_lw7q28y0Mz1qanm80o1_500.gif), you're done.

##Apaxy themes

Don't like the default Apaxy theme? Not to worry, you can make your own.

Copy the `/themes/apaxy` folder and use it as a template for your own theme.

The files used to generate a theme can be found in the `/style` directory:

* `header.html`
* `footer.html`
* `style.css`

Sadly not much can be done to alter the `<table>` structure, but that's about the only limiting factor.

To add in your own icons, you'll need to edit the `.htaccess` file in the _main_ directory.

    AddIcon /{dir folder}/style/icons/gif.png .gif

The above rule will assign an icon named `gif.png` from the directory `/{dir folder}/style/icons/` to any file with the `.gif` extension.

##Mime Types

The default Apaxy theme `/themes/apaxy` has icons in place for the following mime types:

    .aif .aif .asf .asx .avi .bin .c .css .csv .dmg .doc .docm .docx .dot .dotm .eps .flv .gif .htm .html .ico .iff .jar .jpeg .jpg .js .json .log .m3u .m4a .md .mid .mov .mp3 .mp4 .mpa .mpg .msg .mwa .odt .pages .pdf .pkg .png .ps .psd .ra .rar .rb .rm .rss .rtf .shtml .sql .srt .swf .tex .tiff .txt .vob .wav .wmv .wpd .wps .xhtml .xlam .xlr .xls .xlsm .xlsx .xltm .xltx .xml .zip


###Credits

Apaxy owes it's existence to the amazing [h5ai](http://larsjung.de/h5ai/) by [Lars Jung](https://twitter.com/lrsjng). Had I not seen this, I would never have looked into making my own version.

[Faenza Icons](http://tiheum.deviantart.com/art/Faenza-Icons-173323228) are used in the `apaxy` theme.