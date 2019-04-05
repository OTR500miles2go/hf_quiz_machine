// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function () {
  // the selector will match all input controls of type :checkbox
  // and attach a click event handler 
  $("input:checkbox").on('click', function () {
    // in the handler, 'this' refers to the box clicked on
    let $box = $(this);
    let boxName = $box.attr("name");
    if ($box.is(":checked")) {
      // the name of the box is retrieved using the .attr() method
      // as it is assumed and expected to be immutable
      let group = "input:checkbox[name='" + $box.attr("name") + "']";
      // get the response value of the checked box
      let response = $box.attr("value");
      // the checked state of the group/box on the other hand will change
      // and the current value is retrieved using .prop() method
      $(group).prop("checked", false);
      $box.prop("checked", true);
      if (response === "k") {
        $('p#checked-correct[name="' + boxName + '"]').css({ 
          display: "block"
        });
        $('p#checked-false[name="' + boxName + '"]').css({
          display: "none"
        });
      } else {
        $('p#checked-correct[name="' + boxName + '"]').css({
          display: "none"
        });
        $('p#checked-false[name="' + boxName + '"]').css({
          display: "block"
        });
      }
    } else {
      $box.prop("checked", false);
      $('p#checked-correct[name="' + boxName + '"]').css({
        display: "none"
      });
      $('p#checked-false[name="' + boxName + '"]').css({
        display: "none"
      });      
    }
  });
})
