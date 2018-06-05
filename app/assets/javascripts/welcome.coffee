$(document).on "ready page:load", ()->
	$.material.init()
	$(".close-parent").on "click",()->
		$(this).parent().slideUp()