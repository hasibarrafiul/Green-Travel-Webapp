from django.conf import settings
from django.db import models

RATE_CHOICES=[
    (1, '1 - Trash'),
    (2, '2- Horrible'),
    (3, '3- Terrible'),
    (4, '4- Bad'),
    (5, '5- OK'),
    (6, '6- Rideable'),
    (7, '7- Good'),
    (8, '8- Very good'),
    (9, '9- Perfect'),
    (10, '10- Best'),

]

BUS_CHOICES=[
    ('Pan Pacific Sonargoan', 'Pan Pacific Sonargoan'),
    ('Radisson Blu', 'Radisson Blu'),
    ('Hotel De Meridian', 'Hotel De Meridian'),
    ('Grand Plaza Hotel', 'Grand Plaza Hotel'),
    ('Empyrean Hotel', 'Empyrean Hotel'),
    ('The Raintree Dhaka', 'The Raintree Dhaka')
]


class HotelReview(models.Model):
    name = models.CharField(max_length=20)
    date = models.DateTimeField(auto_now_add=True)
    hotelName = models.CharField(choices=BUS_CHOICES, max_length=100, default=None, null=True)
    review = models.TextField(max_length=3000, blank=True)
    rating = models.PositiveSmallIntegerField(choices=RATE_CHOICES, null=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, default=None, on_delete=models.DO_NOTHING)

    def __str__(self):
        return self.name
