# Generated by Django 3.2.9 on 2021-11-11 16:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0009_auto_20210906_2040'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='balaka',
            name='user',
        ),
        migrations.DeleteModel(
            name='Article',
        ),
        migrations.DeleteModel(
            name='balaka',
        ),
    ]
