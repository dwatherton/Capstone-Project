from django.urls import path
from easy_web import views

urlpatterns = [
    # CPSC Website URL's (Views From HTML File - Static Url Mapping)
    path('', views.index, name='index'),
    path('undergraduate.html', views.undergraduate, name='undergraduate'),
    path('graduate.html', views.graduate, name='graduate'),
    path('opportunities_for_students.html', views.opportunities_for_students, name='opportunities_for_students'),
    path('department_news.html', views.department_news, name='department_news'),
    path('faculty_and_staff.html', views.faculty_and_staff, name='faculty_and_staff'),
    path('facilities.html', views.facilities, name='facilities'),
    path('faqs.html', views.faqs, name='faqs'),
    path('about.html', views.about, name='about'),
    path('contact_us.html', views.contact_us, name='contact_us'),

    # CPSC Website URL's (Views From DB Using HttpResponse - Dynamic Url Mapping)
    path('view/<str:page_name>', views.view_page, name='view_page'),

    # Easy Web Admin URL's
    path('contacting', views.contacting, name='contacting'),
    path('register', views.register, name='register'),
    path('registering', views.registering, name='registering'),
    path('login', views.login, name='login'),

    # Easy Web URL's
    path('content_editor', views.content_editor, name='content_editor'),
    path('content_editor/autosave', views.autosave, name='autosave'),
    path('content_editor/page/<str:page_name>', views.edit_page, name='edit_page'),
    path('content_editor/component/<str:component_name>', views.edit_component, name='edit_component'),
    path('content_editor/preview/page/<str:page_name>', views.preview_page, name='preview_page'),
    path('content_editor/update/page/<str:page_name>', views.update_page, name='update_page'),
    path('content_editor/preview/component/<str:component_name>', views.preview_component, name='preview_component'),
    path('content_editor/update/component/<str:component_name>', views.update_component, name='update_component'),
]
