from pytz import timezone
from re import sub
from django.shortcuts import render, redirect
from django.http import HttpResponse
from datetime import datetime
from easy_web.models import Page


# Create your views here.
def index(request):
    # TODO: Update Index.html To Match Project Proposal

    # Get The First Page In The Table
    page = Page.objects.all()[:1].get()

    return render(request, 'index.html', {'page': page})


def undergraduate(request):
    # Get The Undergraduate Page From The Database
    page = Page.objects.all().get(name='undergraduate')

    return render(request, 'undergraduate.html', {'page': page})


def graduate(request):
    # Get The Graduate Page From The Database
    page = Page.objects.all().get(name='graduate')

    return render(request, 'graduate.html', {'page': page})


def opportunities_for_students(request):
    # Get The Opportunities Page From The Database
    page = Page.objects.all().get(name='opportunities_for_students')

    return render(request, 'opportunities_for_students.html', {'page': page})


def department_news(request):
    # Get The Department News Page From The Database
    page = Page.objects.all().get(name='department_news')

    return render(request, 'department_news.html', {'page': page})


def faculty_and_staff(request):
    # Get The Faculty And Staff Page From The Database
    page = Page.objects.all().get(name='faculty_and_staff')

    return render(request, 'faculty_and_staff.html', {'page': page})


def facilities(request):
    # Get The Facilities Page From The Database
    page = Page.objects.all().get(name='facilities')

    return render(request, 'facilities.html', {'page': page})


def faqs(request):
    # Get The Faqs Page From The Database
    page = Page.objects.all().get(name='faqs')

    return render(request, 'faqs.html', {'page': page})


def about(request):
    # Get The About Page From The Database
    page = Page.objects.all().get(name='about')

    return render(request, 'about.html', {'page': page})


def contact_us(request):
    # Get The Contact Us Page From The Database
    page = Page.objects.all().get(name='contact_us')

    return render(request, 'contact_us.html', {'page': page})


def login(request):
    return render(request, 'login.html', {})


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
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./']+ }})", "", content)

    # Add The Pages Content To The HttpResponse
    response.write(content)

    return HttpResponse(response)


def update(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Remove Django Template Tags From HTML (Load Static -> '{% load static %}' | Page Content -> '{{ page.content }}')
    content = sub(r"({% [a-z _./']+ %})|({{ [a-z _./']+ }})", "", content)

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
