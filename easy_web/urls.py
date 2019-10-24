from django.urls import path
from easy_web import views

urlpatterns = [
    # TODO: Change URL, path, For views.content_editor To Something Like 'content_editor', Shouldn't Be The Homepage
    path('', views.index, name='index'),
    path('content_editor/<str:page_name>', views.content_editor, name='content_editor'),
    path('content_editor/preview/<str:page_name>', views.preview, name='preview'),
    path('content_editor/update/<str:page_name>', views.update, name='update'),
]
