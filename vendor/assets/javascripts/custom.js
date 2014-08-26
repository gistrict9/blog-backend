//= Custom JS
//-----------------------

// Popovers
//

$(function () {
	$('.pop').popover({
		trigger: 'focus'
	});
});

// Datetime picker
//

$(function() {
  $('#publish-date').datetimepicker({
    dateFormat: "mm-dd-yy",
    timeFormat: "HH:mm z",
    showTimezone: false,
    useLocalTimezone: false,
    defaultTimezone: '-0400'
  });
});

// Add class for stacked pills
// in navigation
//

$( window ).load(function() {
  enquire.register("screen and (max-width: 768px)", {
      match : function() {
        $('.page').wrap( "<div data-no-turbolink></div>" );
        $('ul#navigation').addClass('nav-stacked');
        $('li#search').removeClass('pull-right').addClass('pull-left');
        $('li#back').removeClass('pull-right').addClass('pull-left');
      },  
      unmatch : function() {
        $('.page').unwrap( "<div data-no-turbolink></div>" );
        $('ul#navigation').removeClass('nav-stacked');
        $('li#search').addClass('pull-right').removeClass('pull-left');
        $('li#back').addClass('pull-right').removeClass('pull-left');
      }
  });
});

// Loading Github Gists
//

function loadGist(element, gistId) {
    var callbackName = "gist_callback";
    window[callbackName] = function (gistData) {
        delete window[callbackName];
        var html = '<link rel="stylesheet" href="' + escapeHtml(gistData.stylesheet) + '"></link>';
        html += gistData.div;
        element.innerHTML = html;
        script.parentNode.removeChild(script);
    };
    var script = document.createElement("script");
    script.setAttribute("src", "https://gist.github.com/" + gistId + ".json?callback=" + callbackName);
    document.body.appendChild(script);
}

// Count characters
//

$(function() {
  var max = 425;

  $('textarea#description').keyup(function () {
    $('.char-count').removeClass('hidden');
    var len = $(this).val().length;
    if (len >= max) {
      $('.char-count').text(' you have reached the limit');
    } else {
      var char = max - len;
      $('.char-count').text(char + ' characters left');
    }
  });

  $('textarea#description').keypress(function(e) {
      if (e.which < 0x20) {
        return;
      }
      if (this.value.length == max) {
        e.preventDefault();
      } else if (this.value.length > max) {
        // Maximum exceeded
        this.value = this.value.substring(0, max);
      }
  });
});