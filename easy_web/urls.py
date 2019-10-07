from django.urls import path
from easy_web import views

urlpatterns = [
    # TODO: Change URL, path, For views.content_editor To Something Like 'content_editor', Shouldn't Be The Homepage
    path('', views.content_editor, name='content_editor'),
    path('preview', views.preview, name='preview'),
    path('update', views.update, name='update'),
]
