from django.urls import path
from easy_web import views

urlpatterns = [
    path('', views.content_editor, name='content_editor'),
]