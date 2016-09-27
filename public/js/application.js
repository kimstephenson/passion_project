$(document).ready(function() {
  var jumboHeight = $('.jumbotron').outerHeight();
  function parallax(){
    var scrolled = $(window).scrollTop();
    $('.bg').css('height', (jumboHeight-scrolled) + 'px');
  }

  $(window).scroll(function(e){
    parallax();
  });

  $("#searchform").on("submit", function(event) {
    searchForm = $(this);
    formData = $(this).serialize();
    event.preventDefault();
    request = $.ajax({
      url: '/users',
      type: 'GET',
      data: formData
    });
    request.done(function(response) {
      searchForm.siblings("#users-list").remove();
      searchForm.after(response);
      searchForm.trigger("reset");
      searchForm.children("input:first").focus();
    });
    request.fail(function() {
      alert("Please enter a valid distance");
    })
  });
});
