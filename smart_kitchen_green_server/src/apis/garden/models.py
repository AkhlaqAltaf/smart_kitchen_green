from django.db import models

from core import settings


class Plant(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    plant_index = models.CharField(max_length=20)
    name = models.CharField(max_length=100)
    planting_date = models.DateField()
    location_lat = models.CharField(max_length=100)
    location_long = models.CharField(max_length=100)
    water_require = models.CharField(max_length=10)
    last_watering = models.DateTimeField(blank=True,null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name


