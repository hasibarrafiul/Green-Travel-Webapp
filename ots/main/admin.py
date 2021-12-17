from django.contrib import admin

from django.contrib import admin
from .models import HotelReview
from .models import ResturantReview

admin.site.register(HotelReview)
admin.site.register(ResturantReview)