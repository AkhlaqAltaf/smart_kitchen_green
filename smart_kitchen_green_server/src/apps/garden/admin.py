from src.apps.garden.models import Plant
from django.contrib import admin


@admin.register(Plant)
class PlantAdmin(admin.ModelAdmin):
    list_display = ('name', 'planting_date', 'user')
    search_fields = ('name', 'user')
    list_filter = ('name', 'user', 'planting_date', 'created_at')
    ordering = ('-created_at',)
