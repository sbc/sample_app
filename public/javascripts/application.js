// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  $('#micropost_content').keyup(function() {
    var left = 140 - $(this).val().length;
    if (left < 0) {
      left = 0;
    }
    $('#counter').text(left);
  });

});
