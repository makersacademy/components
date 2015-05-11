$(document).ready(function() {
  var kernIt = function(el) {
    var text = el.text();
    var textArr = text.split("");
    for (var i = textArr.length - 1; i >= 0; i--) {
      textArr[i] = "<span class='kern-" + textArr[i] + "'>" + textArr[i] + "</span>";
    };
    el.html(textArr.join(""));
  };

  $('.title').each(function(index, el) {
    kernIt($(el));
  });
  
});