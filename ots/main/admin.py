from django.contrib import admin

from django.contrib import admin
from .models import HotelReview, RoomModel
from .models import ResturantReview

admin.site.register(HotelReview)
admin.site.register(ResturantReview)
admin.site.register(RoomModel)
