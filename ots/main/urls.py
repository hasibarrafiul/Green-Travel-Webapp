
from django.urls import path

from . import views

app_name = 'articles'


urlpatterns = [
    path('', views.homepage, name="list"),
    path('contact/$', views.contact, name="contact"),
    path('hotelReview/$', views.hotelReview, name="hotelReview"),
    path('deleteHotelReview/<str:pk>/$', views.deleteHotelReview, name="deleteHotelReview"),
    path('resturantReview/$', views.resturantReview, name="resturantReview"),
    path('deleteResturantReview/<str:pk>/$', views.deleteresturantReview, name="deleteResturantReview"),
    path('placeReview/$', views.placeReview, name="placeReview"),
    path('deleteplaceReview/<str:pk>/$', views.deleteplaceReview, name="deleteplaceReview"),

    path('reservation_new/$', views.reservationnew, name="reservation_new"),
    path('hotel_bookingPdf', views.hotel_bookingPdf, name="hotel_bookingPdf"),

    path('hotel_page/$', views.hotel_page, name="hotel_page"),
    path('room/$', views.RoomShow, name="RoomShow"),

    path('placelist/$', views.placelist, name="placelist"),
    path('place/$', views.place, name="place"),

    path('resturant/$', views.resturantShow, name="resturantShow"),
    path('resturantList/$', views.resturantList, name="resturantList"),

    path('cultural_food/$', views.culturalfood, name="cultural_food"),
    path('contact_new/$', views.contactNew, name="contact_new"),
    path('about/$', views.about, name="about"),
    path('faqs/$', views.faqs, name="faqs"),



    path('user_profile/$', views.UserProfile, name="user_profile"),
    path('create_profile/$', views.createProfile, name="create_profile"),

    path('direct_message/$', views.directmessage, name="direct_message"),
    path('sent_message/$', views.sentmessage, name="sent_message"),

    path('chat_forum/$', views.chatForum, name="chat_forum"),

    path('wishlist/$', views.wishList, name="wishlist"),
    path('deletewishlist/<str:pk>/$', views.deletewishlist, name="deletewishlist"),


    path('hotelsearch/$', views.hotelsearch, name="hotelsearch"),
    path('placesearch/$', views.placesearch, name="placesearch"),
    path('resturantsearch/$', views.resturantsearch, name="resturantsearch"),

    path('blogList/$', views.blogList, name="blogList"),
    path('blogPage/<str:pk>/$', views.blogPage, name="blogPage"),
    path('deleteBlog/<str:pk>/$', views.deleteBlog, name="deleteBlog"),
    path('createBlog/$', views.createBlog, name="createBlog"),
    path('editBlogs/<str:pk>/$', views.editBlogs, name="editBlogs"),

    path('usersearch/$', views.usersearch, name="usersearch"),
    path('searcheduser/$', views.searcheduser, name="searcheduser"),
    path('searchedUserProfile/<str:pk>/$', views.searchedUserProfile, name="searchedUserProfile"),

    path('appRating/$', views.appRating, name="appRating"),
    path('showAppRating/$', views.showAppRating, name="showAppRating"),
    path('deleteAppRating/<str:pk>/$', views.deleteAppRating, name="deleteAppRating"),

]
