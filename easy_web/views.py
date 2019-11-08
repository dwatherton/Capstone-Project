from pytz import timezone
from re import sub
from django.shortcuts import render, redirect
from django.http import HttpResponse
from datetime import datetime
from easy_web.models import Page


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
    return render(request, 'register.html', {})


def login(request):
    return render(request, 'login.html', {})


# DB Version View For Any Page In The Database
def view_page(request, page_name):
    # Get The Page From The Database
    page = Page.objects.all().get(name=page_name)

    # Get The Page Content
    content = page.content

    # Create An Http Response For Rendering Page From DB
    response = HttpResponse()

    # Write The Content To The Response
    response.write(content)

    return HttpResponse(response)


def content_editor(request):
    if request.user.is_authenticated:
        # Get All Pages From The Database
        pages = Page.objects.all()
        # Get The First Page In The Table
        page = Page.objects.all()[:1].get()
        return render(request, 'content_editor.html', {'pages': pages, 'page': page})
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
    # Create An HttpResponse For Rendering Preview
    response = HttpResponse()

    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Page Content -> '{{ page.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./|']+ }})", "", content)

    # Add The Pages Content To The HttpResponse
    response.write(content)

    return HttpResponse(response)


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

    # Create An HttpResponse For Rendering Update Preview
    response = HttpResponse()

    # Add A Styled Success Message To The Response
    response.write('<p style="background-color:#FFFFCC; height:50px; line-height:3em; text-align:center; font-weight:700;">')
    response.write(' Successfully updated on ' + datetime.now().strftime("%m/%d/%Y at %H:%M%p") + '</p>')

    # Add The Pages Content To The HttpResponse
    response.write(content)

    return HttpResponse(response)
