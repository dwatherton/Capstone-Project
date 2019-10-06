// jQuery Function For Bold Button, Turns Highlighted Text Embolded Upon Click, And Vice Versa
jQuery(function($) {
	$(".embolden").click(function() {
		document.execCommand("Bold");
	});
});

// jQuery Function For Italic Button, Turns Highlighted Text Italicized Upon Click, And Vice Versa
jQuery(function($) {
	$(".italicize").click(function() {
		document.execCommand("Italic");
	});
});

// jQuery Function For Underline Button, Turns Highlighted Text Underlined Upon Click, And Vice Versa
jQuery(function($) {
	$(".underline").click(function() {
		document.execCommand("Underline");
	});
});

// jQuery Function For Ordered List Button, Turns Text Into Ordered List Upon Click, And Vice Versa
jQuery(function($) {
	$(".ordered-list").click(function() {
		document.execCommand("InsertOrderedList");
	});
});

// jQuery Function For Unordered List Button, Turns Text Into Unordered List Upon Click, And Vice Versa
jQuery(function($) {
	$(".unordered-list").click(function() {
		document.execCommand("InsertUnorderedList");
	});
});

// jQuery Function For Justify Left Button, Turns Highlighted Text Left Justified Upon Click, And Vice Versa
jQuery(function($) {
	$(".justify-left").click(function() {
		document.execCommand("JustifyLeft");
	});
});

// jQuery Function For Justify Center Button, Turns Highlighted Text Center Justified Upon Click, And Vice Versa
jQuery(function($) {
	$(".justify-center").click(function() {
		document.execCommand("JustifyCenter");
	});
});

// jQuery Function For Justify Right Button, Turns Highlighted Text Right Justified Upon Click, And Vice Versa
jQuery(function($) {
	$(".justify-right").click(function() {
		document.execCommand("JustifyRight");
	});
});

// jQuery Function For Insert Image Button, Upon Click Prompts For An Image URL, Then Inserts The Image At The Cursor Location
jQuery(function($) {
	$(".insert-image").click(function() {
		var url = prompt("To embed an image, please enter the image URL", "");
		if (url != null) {
			document.execCommand("InsertImage", true, url);
		}
	});
});

// jQuery Function For Insert Link Button, Upon Click Prompts For A Link URL, Then Inserts The Link At The Cursor Location (Highlight Text Before Clicking Link Button, If You Want To Title The Link)
jQuery(function($) {
	$(".insert-link").click(function() {
		var url = prompt("To embed a link, please enter the link URL", "");
		if (url != null) {
			document.execCommand("CreateLink", true, url);
		}
	});
});
