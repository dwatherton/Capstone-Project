from django.shortcuts import render
from django.http import HttpResponse


# Create your views here.
def content_editor(request):
    return render(request, 'content_editor.html', {})


def preview(request):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')
    return HttpResponse(content)


def update(request):
    # Get The HTML Content For The Page From The POST Request
    content = request.POST.get('content')

    # TODO: Update Page Model In Database

    # Maybe Redirect To A Preview Of The Saved Page? (Done Below, TODO: Pick This Option - Requires Nothing More)
    return HttpResponse(content)

    # Or Just A Generic "Success!" Page (Done Below, TODO: OR Pick This Option - Requires Creating success.html)
    # return render(request, 'success.html', {})
