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
//= require jquery.turbolinks
//= require jquery_ujs
//= require cocoon
//= require turbolinks
//= require_tree .

ready = function(){

  $('.study-session-mode .card .flip').click(function(){
    $(this).toggleClass('flipped');
  });

  $('.modal').click(function(){
    $(this).removeClass('open').addClass('closed');
  });

  $('.is_correct.button').click(function(){
    if( $(this).hasClass('checked') ){
      $(this).parent().children('.is_correct_input').prop('value', '0')
      $(this).removeClass('checked');
    } else {
      $(this).parent().children('.is_correct_input').prop('value', '1')
      $(this).addClass('checked');
    }
  });

  $('#cards-list').on('cocoon:after-insert', function(e, insertedItem){
    show_hide_secondary_action_buttons();
  });

  $('#cards-list').on('cocoon:after-remove', function(e, insertedItem){
    show_hide_secondary_action_buttons();
  });

  show_hide_secondary_action_buttons();

};

show_hide_secondary_action_buttons = function(){

  if( $('.decks-show #cards-list .card').length == 0 ){
    $('.secondary-actions').hide();
  } else {
    $('.secondary-actions').last().show();
  }

}

$(document).ready(ready);
