from datetime import datetime
from re import sub
from django.contrib.auth.models import User
from django.contrib.gis.geoip2 import GeoIP2
from django.core.mail import send_mail
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from pytz import timezone
from cpsc_website import settings
from easy_web.models import Page, Component, Ip
from easy_web.tokens import account_activation_token


# There Are Two Versions Of Each Page (HTML Version & DB Version)
# HTML Version URL Is /<PAGE_NAME>.html (Ex. 127.0.0.1:8000/undergraduate.html)
# DB Version URL Is /view/<PAGE_NAME> (Ex. 127.0.0.1:8000/view/undergraduate)
# The HTML Version Will Be Kept As Backup, But The Only Copy Needed Is The DB Copy

def index(request):
    # Save or update the client IP address to database
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip_address = x_forwarded_for.split(',')[-1].strip()
    else:
        ip_address = request.META.get('REMOTE_ADDR')
    try:
        get_ip = Ip.objects.get(ip_address=ip_address)
        time_delta = datetime.now().timestamp() - get_ip.timestamp.timestamp()
        # Only update database if the last update was over x seconds ago
        if time_delta > 15:
            get_ip.ip_address = ip_address
            get_ip.visit_count = get_ip.visit_count + 1
            get_ip.timestamp = datetime.now()
            get_ip.save()
            print("\nUpdated visit count for IP:", ip_address)
    except Ip.DoesNotExist:
        g = GeoIP2()
        get_ip = Ip()  # Imported class 'Ip' from model
        get_ip.timestamp = datetime.now()
        get_ip.ip_address = ip_address
        get_ip.visit_count = get_ip.visit_count + 1
        try:
            geo_ip = g.city(ip_address)
            get_ip.country = geo_ip['country_name']
            get_ip.city = geo_ip['city']
            get_ip.lat = geo_ip['latitude']
            get_ip.lon = geo_ip['longitude']
        except Exception:
            pass
        get_ip.save()
        print("\nCreated new entry for IP:", ip_address)

    # Get The First Page In The Table
    page = Page.objects.all()[:1].get()
    # Get The Welcome Message Component From The Database
    welcome_message_component = Component.objects.get(name='welcome_message')
    # Set welcome_message To The Content Of The Welcome Message Component
    welcome_message = welcome_message_component.content
    # Get The Program Links Component From The Database
    program_links_component = Component.objects.get(name='program_links')
    # Set program_links To The Content Of The Program Links Component
    program_links = program_links_component.content
    # Get The Resource Links Component From The Database
    resource_links_component = Component.objects.get(name='resource_links')
    # Set resource_links To The Content Of The Program Links Component
    resource_links = resource_links_component.content
    # Print Message To Console Specifying Which View Is Being Rendered, And Which Page Is Passed To It
    print("\nDisplaying Index.html File! \nThe Page Passed To Index.html Was: " + page.name + "!\n")
    # Render The Homepage, And Pass The First Page In The DB And The Welcome Message
    return render(request, 'index.html', {'page': page, 'welcome_message': welcome_message, 'program_links': program_links, 'resource_links': resource_links})


# HTML Version Views For Each HTML Page
def undergraduate(request):
    page = Page.objects.get(name='undergraduate')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Undergraduate.html File!\n")
    return render(request, 'undergraduate.html', {'page': page})


def graduate(request):
    page = Page.objects.get(name='graduate')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Graduate.html File!\n")
    return render(request, 'graduate.html', {'page': page})


def opportunities_for_students(request):
    page = Page.objects.get(name='opportunities_for_students')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Opportunities_For_Students.html File!\n")
    return render(request, 'opportunities_for_students.html', {'page': page})


def department_news(request):
    page = Page.objects.get(name='department_news')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Department_News.html File!\n")
    return render(request, 'department_news.html', {'page': page})


def faculty_and_staff(request):
    page = Page.objects.get(name='faculty_and_staff')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Faculty_And_Staff.html File!\n")
    return render(request, 'faculty_and_staff.html', {'page': page})


def facilities(request):
    page = Page.objects.get(name='facilities')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Facilities.html File!\n")
    return render(request, 'facilities.html', {'page': page})


def faqs(request):
    page = Page.objects.get(name='faqs')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying FAQs.html File!\n")
    return render(request, 'faqs.html', {'page': page})


def about(request):
    page = Page.objects.get(name='about')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying About.html File!\n")
    return render(request, 'about.html', {'page': page})


def contact_us(request):
    page = Page.objects.get(name='contact_us')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Contact_Us.html File!\n")
    return render(request, 'contact_us.html', {'page': page})


def contacting(request):
    # Get The Question, Name, And Email From The POST Request
    question = request.POST.get('question')
    name = request.POST.get('name')
    email = request.POST.get('email')

    # Set Mail Subject, Message, Sender, And Recipient
    mail_subject = 'CPSC Website Question/Concern From ' + name
    mail_message = 'This Email was sent from the CPSC Websites\' Contact Us Form. See below for Inquiry Specifics: ' + \
                   '\nName: ' + name + \
                   '\nEmail: ' + email + \
                   '\nQuestion/Concern: ' + question + \
                   '\n\n Respond by Emailing ' + name + ' at ' + email + ' the Answer to the Question/Concern above...'
    sender = settings.EMAIL_HOST_USER
    recipients = [settings.EMAIL_HOST_USER]

    # Send The Mail
    # send_mail(subject=mail_subject, message=mail_message, from_email=sender, recipient_list=recipients, fail_silently=False)

    # Print Message To Console For Debugging Contact Us
    for recipient in recipients:
        print("\nMail Sent Successfully! \nTo: " + recipient + " \nFrom: " + sender + " \nSubject: " + mail_subject + " \nMessage: " + mail_message + "\n")
    # This Return Statement Doesn't Do Anything, Using AJAX POST Request Doesn't Change View, It Just Posts Data To URL
    return render(request, 'contact_us.html', {})


def site_info(request):
    page = Page.objects.get(name='site_info')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Site_Info.html File!\n")
    return render(request, 'site_info.html', {'page': page})


def visitors(request):
    data = Ip.objects.all().order_by('-timestamp')
    page = Page.objects.get(name='visitors')
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Visitor.html File!\n")
    return render(request, 'visitors.html', {'data': data, 'page': page})


def register(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Registration/Register.html File!\n")
    return render(request, 'registration/register.html', {})


def registering(request):
    # Get Username And Password From The Request
    email = request.POST.get('email')
    username = request.POST.get('username')
    password = request.POST.get('password')

    # Create A Standard User Account, Will Be Upgraded Later After Approval
    User.objects.create_user(username=username, email=email, password=password)
    user = User.objects.get(username=username)
    # Print Message To Console For Debugging Create User (Standard User)
    print("\nUser Created Successfully! \nUsername: " + username + " \nEmail: " + email)

    # Set Mail Subject, Message To User, Message to Admin, Sender, And Recipienta
    mail_subject = 'EasyWeb Admin Registration ' + '(' + username + ')'
    mail_message = 'Your Registration process has begun.\nPlease wait for an Admin to approve your account and send a confirmation email.'
    html_message = '<p>A User would like to Register an EasyWeb Admin Account with the following credentials: </p>' + \
                   '<p>Email: ' + email + '</p>' \
                   '<p>Username: ' + username + '</p>' \
                   '<p><a href=http://' + settings.SITE_URL + '/activate/' + urlsafe_base64_encode(force_bytes(user.pk)) + '/' + account_activation_token.make_token(user) + '/>Approve this User</a></p>' \
                   '<p><a href=http://' + settings.SITE_URL + '/activate/' + urlsafe_base64_encode(force_bytes(user.pk)) + '/' + account_activation_token.make_token(user)[:-4] + 'deny/>Deny this User</a></p>'
    sender = settings.EMAIL_HOST_USER
    recipients = [settings.EMAIL_HOST_USER]

    # Send One Email To The Admin To Confirm, And One To The User As A Notification
    # send_mail(subject=mail_subject, message=None, from_email=sender, recipient_list=recipients, fail_silently=False, html_message=html_message)
    # send_mail(subject=mail_subject, message=mail_message, from_email=sender, recipient_list=list([email]), fail_silently=False)

    # Print Message To Console For Debugging Registration
    for recipient in recipients:
        print("\nMail Sent Successfully! \nTo: " + recipient + " \nFrom: " + sender + " \nSubject: " + mail_subject + " \nMessage: " + html_message)

    # Create An HttpResponse For Letting The User Know What Is Going On
    response = HttpResponse()

    # Set Content To Explain That The Registration Info Was Sent, And To Link Back To Homepage
    content = '<p>An Email with your registration information has been sent to the Site Admins, please check back' + \
              ' soon... To return home <a href="/">Click Here</a></p>'

    # Write To The Response
    response.write(content)

    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying A Simple HttpResponse To Explain Registration And Provide A Link Back Home!\n")
    # Render The Response
    return HttpResponse(response)


def activate(request, uidb64, token):
    uid = force_text(urlsafe_base64_decode(uidb64))
    user = User.objects.get(pk=uid)

    # Check If Token Is Valid And Set Super_User
    if account_activation_token.check_token(user, token):
        user.is_superuser = True
        user.save()
        print("\nsuper_user created using activation url: ", request)
        # Set Content To Explain That The Registration Was Approved, And To Link Back To Homepage
        content = '<p>User "' + str(user) + '" successfully approved to be super_user... <a href="/">Return Home</a></p>'
        mail_message = 'User has been approved.'
        html_message = '<p>Your Registration has been Approved</p><p><a href=http://' + settings.SITE_URL + '/login>Please Login Here</a></p>'
    else:
        user.is_superuser = False
        user.save()
        print("\nsuper_user denied using activation url: ", request)
        # Set Content To Explain That The Registration Was Denied, And To Link Back To Homepage
        content = '<p>User "' + str(user) + '" successfully denied... <a href="/">Return Home</a></p>'
        mail_message = 'User has been denied.'
        html_message = '<p>Your Registration has been Denied</p><p><a href=http://' + settings.SITE_URL + '>Return to Home Page</a></p>'

    # Send Activation Result Emails To The Admin And User As A Notification
    mail_subject = 'EasyWeb Admin Registration ' + '(' + str(user) + ')'
    # send_mail(subject=mail_subject, message=mail_message, from_email=settings.EMAIL_HOST_USER, recipient_list=[settings.EMAIL_HOST_USER], fail_silently=False)
    # send_mail(subject=mail_subject, message=None, from_email=settings.EMAIL_HOST_USER, recipient_list=[user.email], fail_silently=False, html_message=html_message)

    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying A Simple HttpResponse To Explain Registration Result And Provide A Link Back Home!\n")
    # Render The Response
    return HttpResponse(content)


def login(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Registration/Login.html File!\n")
    return render(request, 'registration/login.html', {})


# DB Version View For Any Page In The Database
def view_page(request, page_name):
    # Get The Page From The Database
    page = Page.objects.all().get(name=page_name)
    # Get The Program Links Component From The Database
    program_links_component = Component.objects.get(name='program_links')
    # Set program_links To The Content Of The Program Links Component
    program_links = program_links_component.content
    # Get The Resource Links Component From The Database
    resource_links_component = Component.objects.get(name='resource_links')
    # Set resource_links To The Content Of The Program Links Component
    resource_links = resource_links_component.content

    # Print Message To Console Specifying Which View Is Being Rendered And Which Page Is Passed To It
    print("\nDisplaying Page_Template.html File! \nThe Page Passed To Page_Template.html Was: " + page.name + "!\n")
    # Render The Page Using The Page Template File, Only Change Is Title And Middle Section Page Content!!
    return render(request, 'page_template.html', {'page': page, 'program_links': program_links, 'resource_links': resource_links})


def content_editor(request):
    if request.user.is_authenticated and request.user.is_superuser:
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The First Page In The Table
        page = Page.objects.all()[:1].get()
        # Get All Components From The Database
        components = Component.objects.all()
        # Get The First Component In The Table
        component = Component.objects.all()[:1].get()
        # Print Message To Console About Redirecting The User To The Content_Editor
        print("\nUser Has Logged In... Redirecting User To '/Content_Editor/'!\n")
        # Redirect User To The Content Editor, Editing The First Page In Database
        return render(request, 'content_editor.html', {'pages': pages, 'page': page, 'components': components, 'component': component})
    else:
        # Print Message To Console Specifying User Is NOT Authenticated (Logged In)
        print("\nUser Is NOT Authenticated! \nRedirecting User To '/'!\n")
        return redirect('/', {})


def edit_component(request, component_name):
    if request.user.is_authenticated and request.user.is_superuser:
        # Get All Components From The Database
        components = Component.objects.all()
        # Get The Component Selected By Component Name
        component = Component.objects.get(name=component_name)
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Print Message To Console Specifying User Status, Which View Is Being Rendered, Which Components Are Passed To It, And The Value Of Component Passed To It
        print("\nUser Is Authenticated! \nDisplaying Content_Editor.html File! \nThe Value Of Component Passed To Content_Editor.html Was: " + component.name + "!\nComponents Include:")
        for c in components:
            print(" - " + c.name)
        return render(request, 'content_editor.html', {'components': components, 'component': component, 'pages': pages})
    else:
        # Print Message To Console Specifying User Is NOT Authenticated (Logged In)
        print("\nUser Is NOT Authenticated! \nRedirecting User To '/'!\n")
        return redirect('/', {})


def edit_page(request, page_name):
    if request.user.is_authenticated and request.user.is_superuser:
        if 'Page Preview' in page_name:
            # Fix page_name By Removing ' Page Preview' From It (Fixes Crash When Trying To View Editor From A Preview)
            page_name = sub(" Page Preview", "", page_name)
            # Redirect The User To The Editor At The Page They Were Editing Previously
            return redirect("/content_editor/page/" + page_name, {})
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The Page Selected By Page Name
        page = Page.objects.get(name=page_name)
        # Get All Components From The Database
        components = Component.objects.all()
        # Print Message To Console Specifying User Status, Which View Is Being Rendered, Which Pages Are Passed To It, And The Value Of Page Passed To It
        print("\nUser Is Authenticated! \nDisplaying Content_Editor.html File! \nThe Value Of Page Passed To Content_Editor.html Was: " + page.name + "!\nPages Include:")
        for p in pages:
            print(" - " + p.name)
        return render(request, 'content_editor.html', {'pages': pages, 'page': page, 'components': components})
    else:
        # Print Message To Console Specifying User Is NOT Authenticated (Logged In)
        print("\nUser Is NOT Authenticated! \nRedirecting User To '/'!\n")
        return redirect('/', {})


def preview_page(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Page Content -> '{{ page.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Get The Page To Preview From The Database And Set It's Properties For Preview (NOTICE: WE DON'T SAVE THE CHANGES THOUGH)
    page = Page.objects.get(name=page_name)
    page.name = page_name + " Page Preview"
    page.content = content

    # Get The Program Links Component From The Database
    program_links_component = Component.objects.get(name='program_links')
    # Set program_links To The Content Of The Program Links Component
    program_links = program_links_component.content
    # Get The Resource Links Component From The Database
    resource_links_component = Component.objects.get(name='resource_links')
    # Set resource_links To The Content Of The Program Links Component
    resource_links = resource_links_component.content

    # Print Message To Console Specifying User Is PREVIEWING Changes, Which View Is Being Rendered, And The Value Of Page Passed To It
    print("\nPREVIEWING CHANGES TO THE " + page_name + " PAGE! \nDisplaying Page_Template.html File! \nThe Value Of Page Passed To Page_Template.html Was: " + page_name + "!\n")
    # Render The Page Preview From The page_template.html File With The Content Currently In The Editor And The program_links And resource_links From The Database
    return render(request, 'page_template.html', {'page': page, 'program_links': program_links, 'resource_links': resource_links})


def update_page(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove The Whitespace Added By ContentEditable (Carriage Returns \r, New Lines \n, Tabs \t, And Spaces ' ' Not Followed By HTML Tags)
    content = sub(r"^([\r\n\t ]+(?!<)+[ ]?)|([\r\n\t ]+(?!<)+[ ]?)$", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Page Content -> '{{ page.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Update Page Model In Database
    page = Page.objects.get(name=page_name)
    page.content = content
    page.updated_at = datetime.now(timezone('America/Chicago'))
    page.save()

    # Get The Time And Date Of The Update For The Success Message
    update_time = datetime.now(timezone('America/Chicago'))

    # Get The Program Links Component From The Database
    program_links_component = Component.objects.get(name='program_links')
    # Set program_links To The Content Of The Program Links Component
    program_links = program_links_component.content
    # Get The Resource Links Component From The Database
    resource_links_component = Component.objects.get(name='resource_links')
    # Set resource_links To The Content Of The Program Links Component
    resource_links = resource_links_component.content

    # Print Message To Console Specifying User Is UPDATING Page, Which View Is Being Rendered, And The Value Of Page And Updatetime Passed To It
    print("\nUPDATING CHANGES TO THE " + page.name + " PAGE! \nDisplaying Page_Template.html File! \nThe Value Of Page Passed To Page_Template.html Was: " + page.name + "!\nThe Value Of Updatetime Was: " + str(update_time) + "!\n")
    # Render The Page Preview From the page_template.html File With The Successfully Updated Message And The program_links And resource_links From The Database
    return render(request, 'page_template.html', {'page': page, 'updatetime': update_time, 'program_links': program_links, 'resource_links': resource_links})


def autosave(request):
    # Get The Page Name And HTML Content For The Page From The POST Request
    page_name = request.POST.get('page_name')
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove The Whitespace Added By ContentEditable (Carriage Returns \r, New Lines \n, Tabs \t, And Spaces ' ' Not Followed By HTML Tags)
    content = sub(r"^([\r\n\t ]+(?!<)+[ ]?)|([\r\n\t ]+(?!<)+[ ]?)$", "", content)

    # Update Page Model In Database
    page = Page.objects.get(name=page_name)
    page.content = content
    page.updated_at = datetime.now(timezone('America/Chicago'))
    page.save()

    # Print Message To Console For Debugging Autosave
    print("\nAutosaved Successfully! \nPage Name: " + page_name + " \nContent:\n" + content + "\n")
    # This Return Statement Doesn't Do Anything, Using AJAX POST Request Doesn't Change View, It Just Posts Data To URL
    return render(request, 'content_editor.html', {})


def preview_component(request, component_name):
    # Get The HTML Content For The Component From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Component Content -> '{{ component.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Get The Component To Preview From The Database And Set It's Properties For Preview (NOTICE: WE DON'T SAVE THE CHANGES THOUGH)
    component = Component.objects.get(name=component_name)
    component.name = component_name + " Component Preview"
    component.content = content

    # Print Message To Console Specifying User Is PREVIEWING Changes, Which View Is Being Rendered, And The Value Of Component Passed To It
    print("\nPREVIEWING CHANGES TO THE " + component_name + " COMPONENT! \nDisplaying Page_Template.html File! \nThe Value Of Component Passed To Page_Template.html Was: " + component_name + "!\n")
    return render(request, 'page_template.html', {'component': component})


def update_component(request, component_name):
    # Get The HTML Content For The Component From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove The Whitespace Added By ContentEditable (Carriage Returns \r, New Lines \n, Tabs \t, And Spaces ' ' Not Followed By HTML Tags)
    content = sub(r"^([\r\n\t ]+(?!<)+[ ]?)|([\r\n\t ]+(?!<)+[ ]?)$", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Component Content -> '{{ component.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Update Component Model In Database
    component = Component.objects.get(name=component_name)
    component.content = content
    component.save()

    # Get The Time And Date Of The Update For The Success Message
    update_time = datetime.now(timezone('America/Chicago'))

    # Print Message To Console Specifying User Is UPDATING Component, Which View Is Being Rendered, And The Value Of Component And Updatetime Passed To It
    print("\nUPDATING CHANGES TO THE " + component_name + " COMPONENT! \nDisplaying Page_Template.html File! \nThe Value Of Component Passed To Page_Template.html Was: " + component_name + "!\nThe Value Of Updatetime Was: " + updatetime + "!\n")
    return render(request, 'page_template.html', {'component': component, 'updatetime': update_time})
