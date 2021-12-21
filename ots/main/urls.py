from django.conf.urls import url
from django.urls import path

from . import views

app_name = 'articles'


urlpatterns = [
    url(r'^$', views.homepage, name="list"),
    url(r'^about/$', views.about, name="about"),
    url(r'^contact/$', views.contact, name="contact"),
    url(r'^hotelReview/$', views.hotelReview, name="hotelReview"),
    path('deleteHotelReview/<str:pk>/$', views.deleteHotelReview, name="deleteHotelReview"),
    url(r'^resturantReview/$', views.resturantReview, name="resturantReview"),
    url(r'^resturantReviewShow/$', views.resturantReviewShow, name="resturantReviewShow"),
    path('deleteResturantReview/<str:pk>/$', views.deleteresturantReview, name="deleteResturantReview"),
    url(r'^placeReview/$', views.placeReview, name="placeReview"),
    path('deleteplaceReview/<str:pk>/$', views.deleteplaceReview, name="deleteplaceReview"),


    url(r'^hotel_booking/$', views.hotel_booking, name="hotel_booking"),
    path('hotel_bookingPdf', views.hotel_bookingPdf, name="hotel_bookingPdf"),

    url(r'^hotel_page/$', views.hotel_page, name="hotel_page"),
    url(r'^room/$', views.RoomShow, name="RoomShow"),

    url(r'^placelist/$', views.placelist, name="placelist"),
    url(r'^place/$', views.place, name="place"),

    url(r'^resturant/$', views.resturantShow, name="resturantShow"),
    url(r'^resturantList/$', views.resturantList, name="resturantList"),


]
