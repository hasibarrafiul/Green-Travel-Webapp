from django.contrib.auth.models import User
from django.db import models


class Article(models.Model):
    title = models.CharField(max_length=100)
    user = models.ForeignKey(User, default=None, on_delete=models.DO_NOTHING)
    # add in thumbnail later
    # add in author later

    def __str__(self):
        return self.title


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
    ('Balaka', 'Balaka'),
    ('Akash', 'Akash'),
    ('Alif', 'Alif'),
    ('Raida', 'Raida'),
    ('VIP', 'VIP'),
    ('BRTC', 'BRTC')
]


class balaka(models.Model):
    name = models.CharField(max_length=20)
    date = models.DateTimeField(auto_now_add=True)
    text = models.TextField(max_length=3000, blank=True)
    rate = models.PositiveSmallIntegerField(choices=RATE_CHOICES, null=True)
    busname = models.CharField(choices=BUS_CHOICES,max_length=20, default= None, null=True)
    user = models.ForeignKey(User, default=None, on_delete=models.DO_NOTHING)

    def __str__(self):
        return self.name
