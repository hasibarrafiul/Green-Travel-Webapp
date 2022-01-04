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
    path('deleteResturantReview/<str:pk>/$', views.deleteresturantReview, name="deleteResturantReview"),
    url(r'^placeReview/$', views.placeReview, name="placeReview"),
    path('deleteplaceReview/<str:pk>/$', views.deleteplaceReview, name="deleteplaceReview"),

    url(r'^reservation_new/$', views.reservationnew, name="reservation_new"),
    path('hotel_bookingPdf', views.hotel_bookingPdf, name="hotel_bookingPdf"),

    url(r'^hotel_page/$', views.hotel_page, name="hotel_page"),
    url(r'^room/$', views.RoomShow, name="RoomShow"),

    url(r'^placelist/$', views.placelist, name="placelist"),
    url(r'^place/$', views.place, name="place"),

    url(r'^resturant/$', views.resturantShow, name="resturantShow"),
    url(r'^resturantList/$', views.resturantList, name="resturantList"),

    url(r'^cultural_food/$', views.culturalfood, name="cultural_food"),
    url(r'^contact_new/$', views.contactNew, name="contact_new"),



    url(r'^user_profile/$', views.UserProfile, name="user_profile"),
    url(r'^create_profile/$', views.createProfile, name="create_profile"),

    url(r'^direct_message/$', views.directmessage, name="direct_message"),
    url(r'^sent_message/$', views.sentmessage, name="sent_message"),

    url(r'^chat_forum/$', views.chatForum, name="chat_forum"),

    url(r'^wishlist/$', views.wishList, name="wishlist"),
    path('deletewishlist/<str:pk>/$', views.deletewishlist, name="deletewishlist"),

    url(r'^offers/$', views.giveOffer, name="offers"),

    url(r'^hotelsearch/$', views.hotelsearch, name="hotelsearch"),
    url(r'^placesearch/$', views.placesearch, name="placesearch"),
    url(r'^resturantsearch/$', views.resturantsearch, name="resturantsearch"),

    url(r'^blogList/$', views.blogList, name="blogList"),
    path('blogPage/<str:pk>/$', views.blogPage, name="blogPage"),
    path('deleteBlog/<str:pk>/$', views.deleteBlog, name="deleteBlog"),
    url(r'^createBlog/$', views.createBlog, name="createBlog"),
    path('editBlogs/<str:pk>/$', views.editBlogs, name="editBlogs"),

    url(r'^usersearch/$', views.usersearch, name="usersearch"),
    url(r'^searcheduser/$', views.searcheduser, name="searcheduser"),
    path('searchedUserProfile/<str:pk>/$', views.searchedUserProfile, name="searchedUserProfile"),

    url(r'^appRating/$', views.appRating, name="appRating"),
    url(r'^showAppRating/$', views.showAppRating, name="showAppRating"),
    path('deleteAppRating/<str:pk>/$', views.deleteAppRating, name="deleteAppRating"),

]
