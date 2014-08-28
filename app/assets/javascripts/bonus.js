$(window).load(function () {
  var bonus = $(".bonus"),
      flipper = $(".flipper"),
      form = bonus.find(".form"),
      code = form.find("#code"),
      error = form.find(".error"),
      download = bonus.find(".download");
      
  bonus.css("width", bonus.find("h1 span").width());
  var flipperMiddle = flipper.height() / 2;
  form.css("top", flipperMiddle - code.outerHeight(true) / 2);
  download.css("top", flipperMiddle - download.height() / 2);
  
  form.find("form").on("ajax:success", function (event, data) {
    if (data.ok) {
      flipper.addClass("flipped");
      download.find("a").prop("href", function (i, url) {
        return url.replace(":download_token:", data.download_token);
      });
    } else {
      error.addClass("shown");
    }
  });
  
  var lastVal;
  code.keyup(function () {
    if (lastVal != code.val()) {
      lastVal = code.val();
      error.removeClass("shown");
    }
  });
});