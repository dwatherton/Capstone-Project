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
