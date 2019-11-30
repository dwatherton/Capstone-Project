import poplib
import re
from email import parser
from pytz import timezone
from re import sub
from django.shortcuts import render, redirect
from django.contrib.auth import get_user_model
from django.http import HttpResponse
from datetime import datetime
from easy_web.models import Page
from django.core.mail import send_mail
from cpsc_website import settings


# There Are Two Versions Of Each Page (HTML Version & DB Version)
# HTML Version URL Is /<PAGE_NAME>.html (Ex. 127.0.0.1:8000/undergraduate.html)
# DB Version URL Is /view/<PAGE_NAME> (Ex. 127.0.0.1:8000/view/undergraduate)
# The HTML Version Will Be Kept As Backup, But The Only Copy Needed Is The DB Copy

def index(request):
    # Get The First Page In The Table
    page = Page.objects.all()[:1].get()

    return render(request, 'index.html', {'page': page})


# HTML Version Views For Each HTML Page
def undergraduate(request):
    return render(request, 'undergraduate.html', {})


def graduate(request):
    return render(request, 'graduate.html', {})


def opportunities_for_students(request):
    return render(request, 'opportunities_for_students.html', {})


def department_news(request):
    return render(request, 'department_news.html', {})


def faculty_and_staff(request):
    return render(request, 'faculty_and_staff.html', {})


def facilities(request):
    return render(request, 'facilities.html', {})


def faqs(request):
    return render(request, 'faqs.html', {})


def about(request):
    return render(request, 'about.html', {})


def contact_us(request):
    return render(request, 'contact_us.html', {})


def register(request):
    return render(request, 'registration/register.html', {})


def registering(request):
    # Get Username And Password From The Request
    username = request.POST.get('username')
    password = request.POST.get('password')

    # Set Mail Subject And Message
    mail_subject = 'EasyWeb Admin Registration ' + '(' + username + ')'
    mail_message = 'A User would like to Register an EasyWeb Admin Account with the following credentials: ' + \
                   '\nUsername: ' + username + \
                   '\nPassword: ' + password + \
                   '\n\n Respond with "Approved" or "Not Approved" to Complete Registration...'

    # Send The Email
    send_mail(subject=mail_subject,
              message=mail_message,
              from_email=settings.EMAIL_HOST_USER,
              recipient_list=[settings.EMAIL_HOST_USER],
              fail_silently=False)

    # Create An HttpResponse For Letting The User Know What Is Going On
    response = HttpResponse()

    content = '<p>An Email with your registration information has been sent to the Site Admins, please check back' + \
              ' soon... To return home <a href="/">Click Here</a></p>'

    # Write To The Response
    response.write(content)

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
                    print("Got The Username: " + username)
                    # Get The Password From The Regex Matching 'Password: ___', Then Remove The 'Password: ' Portion To Get The Password
                    password = sub("Password: ", "", re.search(r"(Password: [\S]+)", payload.get_payload()).group(1))
                    print("Got The Password: " + password)
                    # Get The Django Admin User Model
                    User = get_user_model()
                    # Create The Django Admin SuperUser With The Credentials Retrieved From The Email
                    User.objects.create_superuser(username=username, email=username + '@easywebadmin.com', password=password)

    # Close The POP3 Mail Connection (Note POP3 Will Only Grab A User Once, So Old/Previous Registration Emails Are Not An Issue)
    pop_conn.quit()

    return render(request, 'registration/login.html', {})


# DB Version View For Any Page In The Database
def view_page(request, page_name):
    # Get The Page From The Database
    page = Page.objects.all().get(name=page_name)

    # Render The Page Using The Page Template File, Only Change Is Title And Middle Section Page Content!!
    return render(request, 'page_template.html', {'page': page})


def content_editor(request):
    if request.user.is_authenticated:
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The First Page In The Table
        page = Page.objects.all()[:1].get()
        # Redirect User To The Content Editor, Editing The First Page In Database
        return redirect('/content_editor/' + page.name, {'pages': pages, 'page': page})
    else:
        return redirect('/', {})


def edit_page(request, page_name):
    if request.user.is_authenticated:
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The Page Selected By Page Name
        page = Page.objects.get(name=page_name)
        return render(request, 'content_editor.html', {'pages': pages, 'page': page})
    else:
        return redirect('/', {})


def preview(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Page Content -> '{{ page.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Get The Page To Preview From The Database And Set It's Properties For Preview (WE DON'T SAVE THE CHANGES THOUGH)
    page = Page.objects.get(name=page_name)
    page.name = page_name + " Page Preview"
    page.content = content

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
