from rest_framework import  serializers

from src.apps.garden.models import Plant


class PlantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        fields=('user','name','planting_date','location_lat','location_long','id','created_at','updated_at')
        read_only_fields = ['id', 'created_at', 'updated_at']

