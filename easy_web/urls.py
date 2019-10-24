from django.urls import path
from easy_web import views

urlpatterns = [
    path('', views.index, name='index'),
    path('content_editor/<str:page_name>', views.content_editor, name='content_editor'),
    path('content_editor/preview/<str:page_name>', views.preview, name='preview'),
    path('content_editor/update/<str:page_name>', views.update, name='update'),
]
