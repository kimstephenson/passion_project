$(document).ready(function() {
  var jumboHeight = $('.jumbotron').outerHeight();
  function parallax(){
    var scrolled = $(window).scrollTop();
    $('.bg').css('height', (jumboHeight-scrolled) + 'px');
  }

  $(window).scroll(function(e){
    parallax();
  });

  loadSearchformData();
  showCheckboxForms();
});

var loadSearchformData = function() {
  $("#searchform").on("submit", function(event) {
    event.preventDefault();
    var searchForm = $(this);
    var formData = $(this).serialize();
    var request = $.ajax({
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
}

var showCheckboxForms = function() {
  $(".checkbox-link").on("click", function(event) {
    event.preventDefault();
    var link = $(this)
    var editLinksDiv = link.parents("#edit-links")
    var url = link.attr("href")
    var request = $.ajax({
      url: url,
      type: "GET"
    });
    request.done(function(response) {
      link.hide();
      editLinksDiv.after(response);
    });
    request.fail(function() {
      console.log("Something went wrong...")
    })
  })
}
