from django.contrib import admin

from django.contrib import admin
from .models import HotelReview, RoomModel, PlaceReview, Place, ResturantInfo
from .models import ResturantReview

admin.site.register(HotelReview)
admin.site.register(ResturantReview)
admin.site.register(PlaceReview)
admin.site.register(RoomModel)
admin.site.register(Place)
admin.site.register(ResturantInfo)
