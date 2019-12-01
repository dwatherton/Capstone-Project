/* TODO: Create Universal Scripts Consistent Across All Pages In The Site (Put Them Here!) */
/***** Start Universal Scripts (Scripts That Apply To ALL Pages) *****/

/***** End Universal Scripts *****/




/* TODO: Create Scripts For about.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For about.html *****/

/***** End Scripts For about.html *****/




/* TODO: Create Scripts For contact_us.html (If We Need Any, Put Them Here!) */
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
			document.getElementById('preview-page-content').innerHTML = content;
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
			// Get The Page Name From The Current URL (current_editor/<PAGE_NAME>)
			var page_name = url.substr(url.lastIndexOf('/') + 1);
			// Set AutoSave Interval To Be Called Every (300000 ms = 5 Minutes) On An Editable Page
			setInterval(autosave.bind(null, page_name), 300000);
		}

		// Javascript Helper Function That POST Requests The Page Name And Content To URL ("/content_editor/autosave") Every 5 Minutes, Actual Saving Is Handled In Views.py
		function autosave(page_name) {
			// Get The Page Content
			var content = document.getElementById('content-editor').innerHTML;
			// Make The AJAX POST Request
			$.ajax({
					type: 'POST',
					url: 'autosave',
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




/* TODO: Create Scripts For department_news.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For department_news.html *****/

/***** End Scripts For department_news.html *****/




/* TODO: Create Scripts For facilities.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For facilities.html *****/

/***** End Scripts For facilities.html *****/




/* TODO: Create Scripts For faculty_and_staff.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For faculty_and_staff.html *****/

/***** End Scripts For faculty_and_staff.html *****/




/* TODO: Create Scripts For faqs.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For faqs.html *****/

/***** End Scripts For faqs.html *****/




/* TODO: Create Scripts For graduate.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For graduate.html *****/

/***** End Scripts For graduate.html *****/




/* TODO: Create Scripts For index.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For index.html *****/

/***** End Scripts For index.html *****/




/* TODO: Create Scripts For login.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For login.html *****/

/***** End Scripts For login.html *****/




/* TODO: Create Scripts For opportunities_for_students.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For opportunities_for_students.html *****/

/***** End Scripts For opportunities_for_students.html *****/



/* TODO: Create Scripts For undergraduate.html (If We Need Any, Put Them Here!) */
/***** Start Scripts For undergraduate.html *****/

/***** End Scripts For undergraduate.html *****/
