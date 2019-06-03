var imageSelector = [
    'tr:not(.parent) td.indexcolname a[href$=".png"]',
    'tr:not(.parent) td.indexcolname a[href$=".jpg"]',
    'tr:not(.parent) td.indexcolname a[href$=".gif"]',
].join(', ');

lightGallery(document.getElementById('indexlist'), {
    selector: imageSelector,
    mode: 'lg-slide',
    hideBarsDelay: 2000,
    loop: false,
    hideControlOnEnd: true,
    download: true,
    cssEasing : 'cubic-bezier(0.25, 0, 0.25, 1)'
});
