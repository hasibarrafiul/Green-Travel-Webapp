from django.contrib import admin

from django.contrib import admin
from .models import HotelReview, HotelReservation, PlaceReview
from .models import ResturantReview

admin.site.register(HotelReview)
admin.site.register(ResturantReview)
admin.site.register(HotelReservation)
admin.site.register(PlaceReview)