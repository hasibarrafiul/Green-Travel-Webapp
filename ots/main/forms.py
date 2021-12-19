from django import forms
from . import models


class HotelReview(forms.ModelForm):
    class Meta:
        model = models.HotelReview
        fields = ['name', 'hotelName', 'review', 'rating']


class ResturantReview(forms.ModelForm):
    class Meta:
        model = models.ResturantReview
        fields = ['name', 'resturantName', 'review', 'rating']


class PlaceReview(forms.ModelForm):
    class Meta:
        model = models.PlaceReview
        fields = ['name', 'placeName', 'review', 'rating']
