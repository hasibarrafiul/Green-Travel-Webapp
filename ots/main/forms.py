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


class UserProfile(forms.ModelForm):
    class Meta:
        model = models.userProfile
        fields = ['user_name', 'user_phone', 'user_address', 'bio', 'user_image']


class chatForm(forms.ModelForm):
    class Meta:
        model = models.chat
        fields = ['to_user', 'chat']


class chatForumForm(forms.ModelForm):
    class Meta:
        model = models.chatForumMessages
        fields = ['message']

