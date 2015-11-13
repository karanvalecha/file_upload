// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery-fileupload/basic
//= require bootstrap-sprockets

$(document).on('ready page:load',function(){
	$("#sidebarButton").click(actions);
    $('.label.label-default').css('cursor', 'pointer');
    $('.label.label-default').on('click', function(e){
        $('#commandRow > input')[0].value = e.target.innerHTML;
    });
});
$(window).on('resize', function(){
    if (window.matchMedia('(max-width: 768px)').matches) {
      actions();
    }
});
function actions() {
  $("#bar1, #bar2, #bar3, .sidebar, .main, #sidebarButton, #commandRow").toggleClass("toggle");
}

function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("text/html", ev.target);
}

function drop(ev) {
    ev.preventDefault();
    var data = ev.dataTransfer.getData("text/html");
    // ev.target.appendChild(document.getElementById(data));
    abc = data;
}