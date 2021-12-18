from django.conf.urls import url
from django.urls import path
from django.conf.urls.static import static
from django.conf import settings

from . import views

app_name = 'articles'

urlpatterns = [
    url(r'^$', views.homepage, name="list"),
    url(r'^about/$', views.about, name="about"),
    url(r'^contact/$', views.contact, name="contact"),
    url(r'^ticket/$', views.ticket, name="ticket"),
    url(r'^ticket_page/$', views.ticket_page, name="ticket_page"),
    url(r'^hotel_booking/$', views.hotel_booking, name="hotel_booking"),
    url(r'^hotelReview/$', views.hotelReview, name="hotelReview"),
    url(r'^hotelReviewShow/$', views.hotelReviewShow, name="hotelReviewShow"),
    path('deleteHotelReview/<str:pk>/$', views.deleteHotelReview, name="deleteHotelReview"),
    url(r'^resturantReview/$', views.resturantReview, name="resturantReview"),
    url(r'^resturantReviewShow/$', views.resturantReviewShow, name="resturantReviewShow"),
    path('deleteResturantReview/<str:pk>/$', views.deleteresturantReview, name="deleteResturantReview"),
    url(r'^room/$', views.RoomShow, name="RoomShow"),

]


