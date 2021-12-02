(function($) {

    $(".toggle-password").click(function() {

        $(this).toggleClass("zmdi-eye zmdi-eye-off");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "text") {
          input.attr("type", "password");
        } else {
          input.attr("type", "text");
        }
      });

})(jQuery);