from django.db import models


# Create your models here.
class Page(models.Model):
    name = models.CharField(primary_key=True, max_length=50)
    content = models.TextField()
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()


class Component(models.Model):
    name = models.CharField(primary_key=True, max_length=50)
    content = models.TextField()

class Ip(models.Model):
    timestamp = models.DateTimeField(auto_now=True)
    ip_address = models.GenericIPAddressField(primary_key=True)
    visit_count = models.IntegerField(default=0)
    country = models.CharField(default='None', max_length=100)
    city = models.CharField(default='None', max_length=100)
    lat = models.DecimalField(default='0', max_digits=6, decimal_places=4)
    lon = models.DecimalField(default='0', max_digits=6, decimal_places=4)
