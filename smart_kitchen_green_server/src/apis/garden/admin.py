from src.apis.garden.models import Plant, RecommendedPlants
from django.contrib import admin


@admin.register(Plant)
class PlantAdmin(admin.ModelAdmin):
    list_display = ('recommended_plant', 'planting_date', 'user')
    search_fields = ('recommended_plant', 'user')
    list_filter = ('recommended_plant', 'user', 'planting_date', 'created_at')
    ordering = ('-created_at',)


@admin.register(RecommendedPlants)
class RecommendedPlantsAdmin(admin.ModelAdmin):
    list_display = ('name','category','date','address')
    search_fields = ('name','category','date','address')
    list_filter = ('name','category','date','address')

