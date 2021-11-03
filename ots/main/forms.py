from django import forms
from . import models
from .models import balaka, RATE_CHOICES


class balakareview(forms.ModelForm):
    class Meta:
        model = models.balaka
        fields = ['name', 'text', 'rate', 'busname']

