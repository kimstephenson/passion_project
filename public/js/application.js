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
  submitCheckboxForms();
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
    });
  });
}

var showCheckboxForms = function() {
  $("#edit-links").on("click", ".checkbox-link", function(event) {
    event.preventDefault();
    var link = $(this)
    var editLinksDiv = link.parents("#edit-links")
    var url = link.attr("href")
    var request = $.ajax({
      url: url,
      type: "GET"
    });
    request.done(function(response) {
      editLinksDiv.children(".checkbox-form-div").remove();
      editLinksDiv.children("a:last").after(response);
    });
    request.fail(function() {
      console.log("Something went wrong...")
    });
  });
}

var submitCheckboxForms = function() {
  $("#edit-links").on("submit", ".checkbox-form", function(event) {
    event.preventDefault();
    var form = $(this);
    var url = form.attr("action");
    var formData = form.serialize();
    var request = $.ajax({
      url: url,
      type: "PUT",
      data: formData
    });
    request.done(function(response) {
      form.parent(".checkbox-form-div").remove();
      if(url.match(/instruments/)) {
        $(".inst-list").empty();
        $(".inst-list").append(response);
      } else {
        $(".genre-list").empty();
        $(".genre-list").append(response);
      }
    });
    request.fail(function() {
      console.log("Something went wrong...")
    });
  });
}
