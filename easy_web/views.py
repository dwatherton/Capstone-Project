import poplib
import re
from datetime import datetime
from email import parser
from re import sub
from django.contrib.auth import get_user_model
from django.core.mail import send_mail
from django.http import HttpResponse
from django.shortcuts import render, redirect
from pytz import timezone
from cpsc_website import settings
from easy_web.models import Page


# There Are Two Versions Of Each Page (HTML Version & DB Version)
# HTML Version URL Is /<PAGE_NAME>.html (Ex. 127.0.0.1:8000/undergraduate.html)
# DB Version URL Is /view/<PAGE_NAME> (Ex. 127.0.0.1:8000/view/undergraduate)
# The HTML Version Will Be Kept As Backup, But The Only Copy Needed Is The DB Copy

def index(request):
    # Get The First Page In The Table
    page = Page.objects.all()[:1].get()
    # Print Message To Console Specifying Which View Is Being Rendered And Which Page Is Passed To It
    print("\nDisplaying Index.html File! The Page Passed To Index.html Was: " + page.name + "!\n")
    return render(request, 'index.html', {'page': page})


# HTML Version Views For Each HTML Page
def undergraduate(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Undergraduate.html File!\n")
    return render(request, 'undergraduate.html', {})


def graduate(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Graduate.html File!\n")
    return render(request, 'graduate.html', {})


def opportunities_for_students(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Opportunities_For_Students.html File!\n")
    return render(request, 'opportunities_for_students.html', {})


def department_news(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Department_News.html File!\n")
    return render(request, 'department_news.html', {})


def faculty_and_staff(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Faculty_And_Staff.html File!\n")
    return render(request, 'faculty_and_staff.html', {})


def facilities(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Facilities.html File!\n")
    return render(request, 'facilities.html', {})


def faqs(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying FAQs.html File!\n")
    return render(request, 'faqs.html', {})


def about(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying About.html File!\n")
    return render(request, 'about.html', {})


def contact_us(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Contact_Us.html File!\n")
    return render(request, 'contact_us.html', {})


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
    send_mail(subject=mail_subject, message=mail_message, from_email=sender, recipient_list=recipients, fail_silently=False)

    # Print Message To Console For Debugging Contact Us
    for recipient in recipients:
        print("\nMail Sent Successfully! \nTo: " + recipient + " \nFrom: " + sender + " \nSubject: " + mail_subject + " \nMessage: " + mail_message + "\n")
    # This Return Statement Doesn't Do Anything, Using AJAX POST Request Doesn't Change View, It Just Posts Data To URL
    return render(request, 'contact_us.html', {})


def register(request):
    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Registration/Register.html File!\n")
    return render(request, 'registration/register.html', {})


def registering(request):
    # Get Username And Password From The Request
    username = request.POST.get('username')
    password = request.POST.get('password')

    # Set Mail Subject, Message, Sender, And Recipient
    mail_subject = 'EasyWeb Admin Registration ' + '(' + username + ')'
    mail_message = 'A User would like to Register an EasyWeb Admin Account with the following credentials: ' + \
                   '\nUsername: ' + username + \
                   '\nPassword: ' + password + \
                   '\n\n Respond with "Approved" or "Not Approved" to Complete Registration...'
    sender = settings.EMAIL_HOST_USER
    recipients = [settings.EMAIL_HOST_USER]

    # Send The Email
    send_mail(subject=mail_subject, message=mail_message, from_email=sender, recipient_list=recipients, fail_silently=False)

    # Print Message To Console For Debugging Registration
    for recipient in recipients:
        print("\nMail Sent Successfully! \nTo: " + recipient + " \nFrom: " + sender + " \nSubject: " + mail_subject + " \nMessage: " + mail_message + "\n")

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


def login(request):
    # Establish POP3 Mail Connection With Email Credentials Defined In Settings.py
    pop_conn = poplib.POP3_SSL(settings.EMAIL_HOST)
    pop_conn.user(settings.EMAIL_HOST_USER)
    pop_conn.pass_(settings.EMAIL_HOST_PASSWORD)

    # Get Messages From Server
    messages = [pop_conn.retr(i) for i in range(1, len(pop_conn.list()[1]) + 1)]
    # Concatenate Message Pieces
    messages = [b"\n".join(mssg[1]).decode('utf-8') for mssg in messages]
    # Parse Message Into An Email Object:
    messages = [parser.Parser().parsestr(mssg) for mssg in messages]

    # Loop Through The Retrieved Messages
    for message in messages:
        # Verify Email Is From Site Admin's (webblockheads@gmail.com) And Subject Are Correct (Re: EasyWeb Admin Registration (username))
        if re.search("webblockheads@gmail.com", message['from']) and re.search(r"Re: EasyWeb Admin Registration \([\S]+\)", message['subject']):
            # Loop Through Each Message Payload (Includes Replies - Block Quoted)
            for payload in message.get_payload():
                # Check If The Content Type Is Plain Text (Don't Want HTML/Block Quoted), And Check For A Line Beginning With approved (Punctuation Irrelevant)
                if payload.get_content_type() == 'text/plain' and re.search(r"^(approved)([.!?]?)+|^(\"approved\")([.!?]?)+", payload.get_payload().lower()):
                    print("A new EasyWeb Admin has been Approved via email! See below for more detail: \n\n" + payload.get_payload())
                    # Get The Username From The Regex Matching 'Username: ___', Then Remove The 'Username: ' Portion To Get The Username
                    username = sub("Username: ", "", re.search(r"(Username: [\S]+)", payload.get_payload()).group(1))
                    # Get The Password From The Regex Matching 'Password: ___', Then Remove The 'Password: ' Portion To Get The Password
                    password = sub("Password: ", "", re.search(r"(Password: [\S]+)", payload.get_payload()).group(1))
                    # Get The Django Admin User Model
                    User = get_user_model()
                    # Create The Django Admin SuperUser With The Credentials Retrieved From The Email
                    User.objects.create_superuser(username=username, email=username + '@easywebadmin.com', password=password)
                    # Print Message To Console For Debugging Create SuperUser (Django Admin)
                    print("\nAdmin Created Successfully! \nUsername " + username + " \nPassword: " + password + " \nEmail: " + username + '@easywebadmin.com' + "\n")

    # Close The POP3 Mail Connection (Note POP3 Will Only Grab A User Once, So Old/Previous Registration Emails Are Not An Issue)
    pop_conn.quit()

    # Print Message To Console Specifying Which View Is Being Rendered
    print("\nDisplaying Registration/Login.html File!\n")
    return render(request, 'registration/login.html', {})


# DB Version View For Any Page In The Database
def view_page(request, page_name):
    # Get The Page From The Database
    page = Page.objects.all().get(name=page_name)

    # Print Message To Console Specifying Which View Is Being Rendered And Which Page Is Passed To It
    print("\nDisplaying Page_Template.html File! The Page Passed To Page_Template.html Was: " + page.name + "!\n")
    # Render The Page Using The Page Template File, Only Change Is Title And Middle Section Page Content!!
    return render(request, 'page_template.html', {'page': page})


def content_editor(request):
    if request.user.is_authenticated:
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The First Page In The Table
        page = Page.objects.all()[:1].get()
        # Print Message To Console About Redirecting The User To The Content_Editor
        print("\nUser Has Logged In... Redirecting User To '/Content_Editor/'!\n")
        # Redirect User To The Content Editor, Editing The First Page In Database
        return redirect('/content_editor/' + page.name, {'pages': pages, 'page': page})
    else:
        # Print Message To Console Specifying User Is NOT Authenticated (Logged In)
        print("\nUser Is NOT Authenticated! \nRedirecting User To '/'!\n")
        return redirect('/', {})


def edit_page(request, page_name):
    if request.user.is_authenticated:
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The Page Selected By Page Name
        page = Page.objects.get(name=page_name)
        # Print Message To Console Specifying User Status, Which View Is Being Rendered, Which Pages Are Passed To It, And The Value Of Page Passed To It
        print("\nUser Is Authenticated! \nDisplaying Content_Editor.html File! \nThe Value Of Page Passed To Content_Editor.html Was: " + page.name + "!\nPages Include:")
        for p in pages:
            print(" - " + p.name)
        return render(request, 'content_editor.html', {'pages': pages, 'page': page})
    else:
        # Print Message To Console Specifying User Is NOT Authenticated (Logged In)
        print("\nUser Is NOT Authenticated! \nRedirecting User To '/'!\n")
        return redirect('/', {})


def preview(request, page_name):
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

    # Print Message To Console Specifying User Is PREVIEWING Changes, Which View Is Being Rendered, And The Value Of Page Passed To It
    print("\nPREVIEWING CHANGES TO THE " + page_name + " PAGE! \nDisplaying Page_Template.html File! \nThe Value Of Page Passed To Page_Template.html Was: " + page_name + "!\n")
    # Render The Page Preview From The page_template.html File With The Content Currently In The Editor
    return render(request, 'page_template.html', {'page': page})


def update(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Page Content -> '{{ page.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Update Page Model In Database
    page = Page.objects.get(name=page_name)
    page.content = content
    page.updated_at = datetime.now(timezone('America/Chicago'))
    page.save()

    # Get The Time And Date Of The Update For The Success Message
    updatetime = datetime.now().strftime("%m/%d/%Y at %-I:%M%p")

    # Print Message To Console Specifying User Is UPDATING Page, Which View Is Being Rendered, And The Value Of Page And Updatetime Passed To It
    print("\nUPDATING CHANGES TO THE " + page.name + " PAGE! \nDisplaying Page_Template.html File! \nThe Value Of Page Passed To Page_Template.html Was: " + page.name + "!\nThe Value Of Updatetime Was: " + updatetime + "!\n")
    # Render The Page Preview From the page_template.html File With The Successfully Updated Message
    return render(request, 'page_template.html', {'page': page, 'updatetime': updatetime})


def autosave(request):
    # Get The Page Name And HTML Content For The Page From The POST Request
    page_name = request.POST.get('page_name')
    content = request.POST.get('content')

    # Update Page Model In Database
    page = Page.objects.get(name=page_name)
    page.content = content
    page.updated_at = datetime.now(timezone('America/Chicago'))
    page.save()

    # Print Message To Console For Debugging Autosave
    print("\nAutosaved Successfully! \nPage Name: " + page_name + " \nContent: " + content + "\n")
    # This Return Statement Doesn't Do Anything, Using AJAX POST Request Doesn't Change View, It Just Posts Data To URL
    return render(request, 'content_editor.html', {})
