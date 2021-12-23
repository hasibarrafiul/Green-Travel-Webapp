from django.conf.urls import url
from django.urls import path

from . import views

app_name = 'articles'


urlpatterns = [
    url(r'^$', views.homepage, name="list"),
    url(r'^about/$', views.about, name="about"),
    url(r'^contact/$', views.contact, name="contact"),
    url(r'^bolakareview/$', views.bolakareview, name="bolakareview"),
    url(r'^ticket/$', views.ticket, name="ticket"),
    #path('deletebalaka/<str:pk>/$', views.deletebalaka, name="deletebalaka"),
    url(r'^ticket_page/$', views.ticket_page, name="ticket_page"),
    url(r'^cultural_food/$', views.culturalfood, name="cultural_food"),

]
