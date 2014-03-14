// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ jQuery(document).foundation(); });

// $( document ).click(function() {
//   $( "#toggle-chore" ).toggle( "drop" );
// });


// $(document).ready(function(){
//   $('#toggle-chore').on('click', function() {
//     $('div').toggle(option)
//   })
// });


$(document).ready(function(){
  phoneNumber();

  (function() {
    var userHouseList = $('#user-house-list');

    if (userHouseList.length) {
      var currentlyViewing = userHouseList.data('activeId');
      var houseLink = userHouseList.children('dd').children('a.house-tab');
      houseLink.each(function() {
        if ($(this).data('id') === currentlyViewing) {
          $(this).addClass('active')
        }
      })
    }
  })();

// new comment submission

  $("#new_comment").on("submit", function(e) {
    e.preventDefault();

    var url = $(this).attr("action");
    console.log(url);

    $.ajax({
      url: url,
      data: $(this).serialize(),
      type: "POST",
      dataType: "json",
      success: function(data) {
        console.log(data);
        $(".comments-panel").text(data.comment);
      }
    });
  });


// new chore submission

  // $('#new_chore_link').on("click", function(e){
  //   e.preventDefault();

  $('#chore_form').show();
  //   $(this).hide();
  // });

  $("#new_chore").on("submit", function(e) {
    e.preventDefault();

    var url = $(this).attr("action");
    console.log(url);

    $.ajax({
      url: url,
      data: $(this).serialize(),
      dataType: "json",
      type: "POST",
      success: function(data) {
        console.log(data);
        var chore = ich.chore(data);
        $(".incomplete_chore_list").prepend(chore);
        $('#chore_name').val("");
      }
    });
  });

  $('#shoppinglist-form').show();
  //   // $(this).hide();
  // });

  $("#new_shoppinglist").on("submit", function(e) {
    e.preventDefault();

    var url = $(this).attr("action");
    console.log(url);

    $.ajax({
      url: url,
      data: $(this).serialize(),
      dataType: "json",
      type: "POST",
      success: function(data) {
        // console.log(data);
        var shoppinglist = ich.shoppinglist(data);
        $(".incomplete-shopping-list").prepend(shoppinglist);
        $('#shoppinglist_name').val("");
      }
    });
  });

});