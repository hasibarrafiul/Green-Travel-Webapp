from django.conf.urls import url
from django.urls import path

from . import views

app_name = 'articles'


urlpatterns = [
    url(r'^$', views.homepage, name="list"),
    url(r'^about/$', views.about, name="about"),
    url(r'^contact/$', views.contact, name="contact"),
    url(r'^bolaka/$', views.bolaka, name="bolaka"),
    url(r'^offers_page/$', views.offers, name="offers_page"),
    url(r'^bolakareview/$', views.bolakareview, name="bolakareview"),
    url(r'^ticket/$', views.ticket, name="ticket"),
    path('deletebalaka/<str:pk>/$', views.deletebalaka, name="deletebalaka"),
    url(r'^ticket_page/$', views.ticket_page, name="ticket_page"),


    # Air
    url(r'^Air_Biman_Bangladesh/$', views.Air_Biman_Bangladesh, name="Air_Biman_Bangladesh"),
    url(r'^Air_Novoair/$', views.Air_Novoair, name="Air_Novoair"),
    url(r'^Air_US_Bangla/$', views.Air_US_Bangla, name="Air_US_Bangla"),

    # Bus
    url(r'^Bus_Akash/$', views.Bus_Akash, name="Bus_Akash"),
    url(r'^Bus_Alif/$', views.Bus_Alif, name="Bus_Alif"),
    url(r'^Bus_Anabil/$', views.Bus_Anabil, name="Bus_Anabil"),
    url(r'^Bus_BRTC/$', views.Bus_BRTC, name="Bus_BRTC"),
    url(r'^Bus_Green_Dhaka/$', views.Bus_Green_Dhaka, name="Bus_Green_Dhaka"),
    url(r'^Bus_Raida/$', views.Bus_Raida, name="Bus_Raida"),
    url(r'^Bus_Skyline/$', views.Bus_Skyline, name="Bus_Skyline"),
    url(r'^Bus_Supravat/$', views.Bus_Supravat, name="Bus_Supravat"),
    url(r'^Bus_VIP/$', views.Bus_VIP, name="Bus_VIP"),

    # Train
    url(r'^Train_Chitra_Express/$', views.Train_Chitra_Express, name="Train_Chitra_Express"),
    url(r'^Train_Ekota_Express/$', views.Train_Ekota_Express, name="Train_Ekota_Express"),
    url(r'^Train_Mahanagar_Godhuli/$', views.Train_Mahanagar_Godhuli, name="Train_Mahanagar_Godhuli"),
    url(r'^Train_Suborno_Express/$', views.Train_Suborno_Express, name="Train_Suborno_Express"),
    url(r'^Train_Tista_Express/$', views.Train_Tista_Express, name="Train_Tista_Express"),

    url(r'^(?P<slug>[\w-]+)/$', views.homepage, name="list"),
]
