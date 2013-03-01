# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){

// hide it first
$("#spinner").hide();

// when an ajax request starts, show spinner
$.ajaxStart(function(){
    $("#spinner").show();
});

// when an ajax request complets, hide spinner    
$.ajaxStop(function(){
    $("#spinner").hide();
});