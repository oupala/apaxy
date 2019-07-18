// content filtering, based on "light javascript table filter" by Chris Coyier
// https://codepen.io/chriscoyier/pen/tIuBL - MIT License
(function(document) {
	'use strict';

	var TableFilter = (function(Arr) {

		// the search bar element
		var _input;

		// find all rows of all tables and call _filter on them
		function _onInputEvent(e) {
			_input = e.target;
			var tables = document.getElementsByTagName('table');
			Arr.forEach.call(tables, function(table) {
				Arr.forEach.call(table.tBodies, function(tbody) {
					Arr.forEach.call(tbody.rows, _filter);
				});
			});
		}

		// show or hide a row based on the value of _input
		function _filter(row) {
			// skip "special" rows
			if (row.className.indexOf('indexhead') != -1 || row.className.indexOf('parent') != -1) {
				return;
			}

			// only check the 'name' field
			var text = row.getElementsByTagName('td')[1].textContent.toLowerCase();
			var val = _input.value.toLowerCase();

			// change display type to show / hide this row
			row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
		}

		return {
			init: function() {
				// grab the 1st child and add the indexhead class. tr:nth-child(1)
				var row = document.getElementsByTagName('tr')[0];
				// some versions of apache already add this class
				if (row !== null && row.className.indexOf('indexhead') == -1) {
					row.className += ' indexhead';
				}

				// grab the 2nd child and add the parent class. tr:nth-child(2)
				row = document.getElementsByTagName('tr')[1];
				// when apaxy is installed at doc root, there is no "parent directory" row
				if (row !== null && row.getElementsByTagName('td')[1].textContent === 'Parent Directory') {
					row.className += ' parent';
				}

				// find the search box and bind the input event
				document.getElementById('filter').oninput = _onInputEvent;
			}
		};

	})(Array.prototype);

	document.addEventListener('readystatechange', function() {
		if (document.readyState === 'complete') {
			TableFilter.init();
		}
	});

})(document);

// generate a breadcrumb
var uri = window.location.pathname.substr(1);
var arr = uri.split('/');
var url = ""
var bread = '<li><strong><a href="/">Home</a></strong></li>';
var cont = 1;
arr.forEach(function(value){
        url = url + '/' + value;
        if(value != ''){
            if(arr.length == cont+1)
                bread += "<li class='active'>"+decodeURI(value)+"</li>";
            else
                bread += "<li><a href='"+url+"'>"+decodeURI(value)+"</a></li>";
        }
        cont++;
});
document.getElementById("breadcrumb").innerHTML = bread;
if (uri.substring(uri.length-1) != '/'){
        var indexes = document.getElementsByClassName('indexcolname'),
        i = indexes.length;
        while (i--){
            var a = indexes[i].getElementsByTagName('a')[0];
            a.href =  uri + '/' + a.getAttribute('href',2);
        }
}
