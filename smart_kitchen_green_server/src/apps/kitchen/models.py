from django.db import models
from django.contrib.auth.models import User

from core import settings


class Product(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    quantity = models.PositiveIntegerField()
    expiry_date = models.DateField()
    type_choices = [
        ('CAN_USE', 'Can Use Appliance'),
        ('CANNOT_USE', 'Cannot Use Appliance'),
    ]
    type = models.CharField(max_length=20, choices=type_choices)
    appliance_time = models.PositiveIntegerField(null=True, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Appliance(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    type_choices = [
        ('COOLER', 'Cooler'),
        ('HEATER', 'Heater'),
    ]
    type = models.CharField(max_length=20, choices=type_choices)
    can_cool = models.BooleanField(default=False)
    can_heat = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name
