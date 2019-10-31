from pytz import timezone
from re import sub
from django.shortcuts import render
from django.http import HttpResponse
from datetime import datetime
from easy_web.models import Page


# Create your views here.
def index(request):
    # TODO: Update Index.html To Match Project Parameters

    # Get The First Page In The Table
    page = Page.objects.all()[:1].get()

    return render(request, 'index.html', {'page': page})


def content_editor(request, page_name):
    # Get All Pages From The Database
    pages = Page.objects.all()

    # Get The Page Selected By Page Name
    page = Page.objects.get(name=page_name)

    # Render The Content Editor And Pass It Page/Pages
    return render(request, 'content_editor.html', {'pages': pages, 'page': page})


def preview(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)
    return HttpResponse(content)


def update(request, page_name):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # Remove HTML Tags Of Non-Printing Characters (Space -> '<p></p>' | Enter -> '<div></div>') In The Content Editor
    content = sub(r"(<[a-z]+></[a-z]+>)", "", content)

    # Update Page Model In Database
    page = Page.objects.get(name=page_name)
    page.content = content
    page.updated_at = datetime.now(timezone('America/Chicago'))
    page.save()

    style = '<p style="background-color:#FFFFCC; height:50px; line-height:3em; text-align:center; font-weight:700;">'
    message = page.name + ' Successfully updated on ' + datetime.now().strftime("%m/%d/%Y at %H:%M%p") + '</p>'

    # Show Message Saying Page Successfully Updated With A Timestamp And A Preview Of The Content From Editor
    return HttpResponse(style + message + content)
