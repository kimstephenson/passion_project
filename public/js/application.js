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
  // submitCheckboxForms();
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
      editLinksDiv.children(".checkbox-form").remove();
      editLinksDiv.children("a:last").after(response);
    });
    request.fail(function() {
      console.log("Something went wrong...")
    })
  })
}

// var submitCheckboxForms = function() {
//   $("#edit-links").on("submit", ".checkbox-form", function(event) {
//     event.preventDefault();
//     console.log("inside listener");
//   });
// }
