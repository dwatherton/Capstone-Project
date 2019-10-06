from django.shortcuts import render


# Create your views here.
def content_editor(request):
    return render(request, 'content_editor.html', {})
