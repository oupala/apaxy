#Apaxy

Apaxy is a simple, customisable theme for your Apache directory listing. Turn [this](http://bukk.it) into [this]().

##Installation

Apaxy is simple to install, all you need is a server running Apache and FTP access to the folder you'd like use.

* Download and unzip.
* Copy the contents of `/apaxy` to the folder on your server you're going to use as the listing directory.
* Rename `htaccess.txt` to `.htaccess` in both the main and `/theme` folder.
* [Treat yo'self](http://25.media.tumblr.com/tumblr_lw7q28y0Mz1qanm80o1_500.gif), you're done.

##Styling Apaxy

If you'd like to edit the appearance of Apaxy, look in the `/theme` folder for the ollowing files:

* `header.html`
* `footer.html`
* `style.css`

Go nuts. Sadly not much can be done to alter the `<table>` structure.

Adding your own icons is a little more involved. You'll need to edit the `.htaccess` file in your main directory. Look for the following as an example:

    AddIcon /{your_folder}/theme/icons/gif.png .gif

The above rule will assign an icon named `gif.png` from the directory `/{your_folder}/theme/icons/` to any file with the `.gif` extension.

##Mime Types

The default Apaxy theme `/themes/apaxy` has icons in place for the following mime types:

    .aif .aif .asf .asx .avi .bin .c .css .csv .dmg .doc .docm .docx .dot .dotm .eps .flv .gif 
    .htm .html .ico .iff .jar .jpeg .jpg .js .json .log .m3u .m4a .md .mid .mov .mp3 .mp4 .mpa 
    .mpg .msg .mwa .odt .pages .pdf .pkg .png .ps .psd .ra .rar .rb .rm .rss .rtf .shtml 
    .sql .srt .swf .tex .tiff .txt .vob .wav .wmv .wpd .wps .xhtml .xlam .xlr .xls .xlsm .xlsx 
    .xltm .xltx .xml .zip


###Credits

Apaxy owes it's existence to the amazing [h5ai](http://larsjung.de/h5ai/) by [Lars Jung](https://twitter.com/lrsjng). Had I not seen this, I would never have looked into making my own version.

Icons are the [Faenza Icons](http://tiheum.deviantart.com/art/Faenza-Icons-173323228).