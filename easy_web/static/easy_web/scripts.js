/***** Start Universal Scripts (Scripts That Apply To ALL Pages) *****/

/***** End Universal Scripts *****/




/***** Start Scripts For about.html *****/

/***** End Scripts For about.html *****/




/***** Start Scripts For contact_us.html *****/
// jQuery Function For Sending Contact Us Email
jQuery(function($) {
	$(document).ready(function() {
		$('.contact-button').click(function() {
			// Get The Name, Email, And Question From The Form Input Fields
			var name = document.getElementById('id_name').value;
			var email = document.getElementById('id_email').value;
			var question = document.getElementById('id_question').value;
			// Make The AJAX POST Request
			$.ajax({
					type: 'POST',
					url: '/contacting',
					data: {csrfmiddlewaretoken: window.CSRF_TOKEN, name: name, email: email, question: question},
					success: function() {
						console.log('Contact Email sent at ' + new Date());
						// Display Contact Email Sent Alert
						contactEmailSentAlert();
					}
			})
		});

		// Javascript Helper Function That Shows And Hides A Bootstrap Alert Banner Upon Sending Contact Us Email (Banner Lasts For 10 Seconds Before Being Hidden)
		function contactEmailSentAlert() {
			$(".contact-email-sent-alert").show();
			setTimeout(function() {
				$(".contact-email-sent-alert").hide();
			}, 10000);
		}
	});
});
/***** End Scripts For contact_us.html *****/




/***** Start Scripts For content_editor.html *****/
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

// jQuery Function For Hiding And Un-hiding The Font Family Dropdown Menu Upon Click
jQuery(function($) {
	$(".font-family-dropdown-button").click(function() {
		document.getElementById("font-family-dropdown").classList.toggle('show');
	});
});

// jQuery Function For Hiding The Font Family Dropdown Menu When The User Clicks Off Of It
jQuery(function($) {
	$(window).click(function(e) {
		if (!e.target.matches('.font-family-dropdown-button') && !e.target.matches('.search') && !e.target.matches('.fa-caret-down')) {
			var fontFamilyDropdown = document.getElementById("font-family-dropdown");
			if (fontFamilyDropdown.classList.contains('show')) {
				fontFamilyDropdown.classList.remove('show');
			}
		}
	});
});

// jQuery Function For Font Family Selection Button, Turns Highlighted Text To The Font Family Selected
jQuery(function($) {
	$('.font-family-selection').click(function() {
		var fontStyle = $(this).text();
		document.execCommand('fontName', false, fontStyle);
		document.getElementById("font-family").innerHTML = fontStyle + " <i class=\"fa fa-caret-down\"></i>";
	});
});

// jQuery Function For Filtering The Font Family Results Displayed In The Font Family Dropdown Menu (When Searching)
jQuery(function($) {
	$('#font-family-search').keyup(function() {
		var input, filter, ul, li, a, i;
		input = document.getElementById("font-family-search");
		filter = input.value.toUpperCase();
		div = document.getElementById("font-family-dropdown");
		button = div.getElementsByTagName("button");
		for (i = 0; i < button.length; i++) {
			txtValue = button[i].textContent || button[i].innerText;
			if (txtValue.toUpperCase().indexOf(filter) > -1) {
				button[i].style.display = "";
			} else {
				button[i].style.display = "none";
			}
		}
	});
});

// jQuery Function For Hiding And Un-hiding The Font Size Dropdown Menu Upon Click
jQuery(function($) {
	$(".font-size-dropdown-button").click(function() {
		document.getElementById("font-size-dropdown").classList.toggle('show');
	});
});

// jQuery Function For Hiding The Font Size Dropdown Menu When The User Clicks Off Of It
jQuery(function($) {
	$(window).click(function(e) {
		if (!e.target.matches('.font-size-dropdown-button') && !e.target.matches('.fa-caret-down')) {
			var fontSizeDropdown = document.getElementById("font-size-dropdown");
			if (fontSizeDropdown.classList.contains('show')) {
				fontSizeDropdown.classList.remove('show');
			}
		}
	});
});

// jQuery Function For Font Size Selection Button, Turns Highlighted Text To The Font Size Selected
jQuery(function($) {
	$('.font-size-selection').click(function() {
		var fontSize = $(this).text();
		document.execCommand('fontSize', false, fontSize);
		document.getElementById("font-size").innerHTML = fontSize + " <i class=\"fa fa-caret-down\"></i>";
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

// jQuery Function For Retrieving The HTML Formatted Text Inside Of The Content Editor, Then Passing It To A Hidden Form's Textarea For POST Requesting The Data To The Database! (The contenteditable="true" Elements Of A Page/Form CANNOT Directly Be POST Requested)
jQuery(function($) {
	$(".preview").click(function() {
		if (document.getElementById('content-editor') != null)
		{
			var content = document.getElementById('content-editor').innerHTML;
			if (document.getElementById('preview-page-content') != null)
			{
				document.getElementById('preview-page-content').innerHTML = content;
			}
			else
			{
				document.getElementById('preview-component-content').innerHTML = content;
			}
			document.getElementById('buttonClicked').innerHTML = "Preview";
		}
	});
});

// jQuery Function For Retrieving The HTML Formatted Text Inside Of The Content Editor, Then Passing It To A Hidden Form's Textarea For POST Requesting The Data To The Database! (The contenteditable="true" Elements Of A Page/Form CANNOT Directly Be POST Requested)
jQuery(function($) {
	$(".update").click(function() {
		if (document.getElementById('content-editor') != null)
		{
			var content = document.getElementById('content-editor').innerHTML;
			if (document.getElementById('update-page-content') != null)
			{
				document.getElementById('update-page-content').innerHTML = content;
			}
			else
			{
				document.getElementById('update-component-content').innerHTML = content;
			}
			document.getElementById('update-page-content').innerHTML = content;
			document.getElementById('buttonClicked').innerHTML = "Update";
		}
	});
});

// jQuery Function For Refreshing The Page After The User Clicks The Update Button And Closes The Tab That Shows Updated Successfully With A Preview Of The Content - Applies Updated Styles To The Content
jQuery(function($) {
	$(window).on("focus", function() {
		if (document.getElementById('buttonClicked') != null && document.getElementById('buttonClicked').innerHTML == "Update") {
			location.reload();
		}
	});
});

// jQuery Function For Autosaving Any Page Loaded Into The Content Editor (Autosaves Every 5 Minutes)
jQuery(function($) {
	$(document).ready(function() {
		if (document.getElementById('content-editor') != null)
		{
			var url = location.href;
			// Check The Url For Presence Of ("/content_editor/page/" Url Upon Clicking A Page) Before Enabling Autosave, ("/content_editor" Url Upon Login) Doesn't Autosave
			if (url.indexOf('/content_editor/page/') > -1) {
				// Get The Page Name From The Current URL (content_editor/<PAGE_NAME>)
				var page_name = url.substr(url.lastIndexOf('/') + 1);
				// Set AutoSave Interval To Be Called Every (300000 ms = 5 Minutes) On An Editable Page
				setInterval(autosave.bind(null, page_name), 300000);
			}
		}

		// Javascript Helper Function That POST Requests The Page Name And Content To URL ("/content_editor/autosave") Every 5 Minutes, Actual Saving Is Handled In Views.py
		function autosave(page_name) {
			// Get The Page Content
			var content = document.getElementById('content-editor').innerHTML;
			// Make The AJAX POST Request
			$.ajax({
					type: 'POST',
					url: '/content_editor/autosave',
					data: {csrfmiddlewaretoken: window.CSRF_TOKEN, page_name: page_name, content: content},
					success: function() {
						console.log('Autosaved Page: ' + page_name + ' at ' + new Date());
						// Display Autosave Alert Banner
						autosaveAlert();
					}
			})
		}

		// Javascript Helper Function That Shows And Hides A Bootstrap Alert Banner Upon Autosaving (Banner Lasts For 10 Seconds Before Being Hidden)
		function autosaveAlert() {
			$(".autosave-alert").show();
			setTimeout(function() {
				$(".autosave-alert").hide();
			}, 10000);
		}
	});
});
/***** End Scripts For content_editor.html *****/




/***** Start Scripts For department_news.html *****/

/***** End Scripts For department_news.html *****/




/***** Start Scripts For facilities.html *****/

/***** End Scripts For facilities.html *****/




/***** Start Scripts For faculty_and_staff.html *****/

/***** End Scripts For faculty_and_staff.html *****/




/***** Start Scripts For faqs.html *****/

/***** End Scripts For faqs.html *****/




/***** Start Scripts For graduate.html *****/

/***** End Scripts For graduate.html *****/




/***** Start Scripts For index.html *****/
// jQuery Function For The Popup Welcome Message; Will Occur On First Load Only.
jQuery(function ($) {

	'use strict';

	$.fn.firstVisitPopup = function (settings) {

		var $body = $('body');
		var $dialog = $(this);
		var $blackout;
		var setCookie = function (name, value) {
			var date = new Date(),
				expires = 'expires=';
			date.setTime(date.getTime() + 2592000000); // Expires in 30 days
			expires += date.toGMTString();
			document.cookie = name + '=' + value + '; ' + expires + '; path=/';
		}
		var getCookie = function (name) {
			var allCookies = document.cookie.split(';'),
				cookieCounter = 0,
				currentCookie = '';
			for (cookieCounter = 0; cookieCounter < allCookies.length; cookieCounter++) {
				currentCookie = allCookies[cookieCounter];
				while (currentCookie.charAt(0) === ' ') {
					currentCookie = currentCookie.substring(1, currentCookie.length);
				}
				if (currentCookie.indexOf(name + '=') === 0) {
					return currentCookie.substring(name.length + 1, currentCookie.length);
				}
			}
			return false;
		}
		var showMessage = function () {
			$blackout.show();
			$dialog.show();
		}
		var hideMessage = function () {
			$blackout.hide();
			$dialog.hide();
			setCookie('fvpp' + settings.cookieName, 'true');
		}

		$body.append('<div id="fvpp-blackout"></div>');
		$dialog.append('<a id="fvpp-close">&#10006;</a>');
		$blackout = $('#fvpp-blackout');

		if (getCookie('fvpp' + settings.cookieName)) {
			hideMessage();
		} else {
			showMessage();
		}

		$(settings.showAgainSelector).on('click', showMessage);
		$body.on('click', '#fvpp-blackout, #fvpp-close', hideMessage);

	};

});
/***** End Scripts For index.html *****/




/***** Start Scripts For login.html *****/

/***** End Scripts For login.html *****/




/***** Start Scripts For opportunities_for_students.html *****/

/***** End Scripts For opportunities_for_students.html *****/



/***** Start Scripts For undergraduate.html *****/

/***** End Scripts For undergraduate.html *****/
