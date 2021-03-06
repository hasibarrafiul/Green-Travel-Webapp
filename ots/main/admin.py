from django.contrib import admin

from django.contrib import admin
from .models import HotelReview, RoomModel, PlaceReview, Place, ResturantInfo, HotelReservation, userProfile, chat
from .models import ResturantReview, chatForumMessages, wishlist, userBlog, appReview

admin.site.register(HotelReview)
admin.site.register(ResturantReview)
admin.site.register(PlaceReview)
admin.site.register(RoomModel)
admin.site.register(Place)
admin.site.register(ResturantInfo)
admin.site.register(HotelReservation)
admin.site.register(userProfile)
admin.site.register(chat)
admin.site.register(chatForumMessages)
admin.site.register(wishlist)
admin.site.register(userBlog)
admin.site.register(appReview)
