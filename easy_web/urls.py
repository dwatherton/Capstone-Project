from django.urls import path
from easy_web import views

# TODO: Decide If We Want Both Views (An HTML File And A Page In DB, Or Just The Page In The DB)
urlpatterns = [
    # CPSC Website URL's (Views From HTML File - Static Url Mapping)
    path('', views.index, name='index'),
    path('undergraduate', views.undergraduate, name='undergraduate'),
    path('graduate', views.graduate, name='graduate'),
    path('opportunities_for_students', views.opportunities_for_students, name='opportunities_for_students'),
    path('department_news', views.department_news, name='department_news'),
    path('faculty_and_staff', views.faculty_and_staff, name='faculty_and_staff'),
    path('facilities', views.facilities, name='facilities'),
    path('faqs', views.faqs, name='faqs'),
    path('about', views.about, name='about'),
    path('contact_us', views.contact_us, name='contact_us'),
    path('login', views.login, name='login'),

    # CPSC Website URL's (Views From DB Using 'page.html' - Dynamic Url Mapping)
    path('view/<str:page_name>', views.view_page, name='view_page'),

    # Easy Web URL's
    path('content_editor', views.content_editor, name='content_editor'),
    path('content_editor/<str:page_name>', views.edit_page, name='edit_page'),
    path('content_editor/preview/<str:page_name>', views.preview, name='preview'),
    path('content_editor/update/<str:page_name>', views.update, name='update'),
]
