from rest_framework import  serializers

from src.apis.garden.models import Plant, RecommendedPlants


class RecommendedPlantsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecommendedPlants
        fields = '__all__'  # Include all
class PlantSerializer(serializers.ModelSerializer):
    recommended_plant = RecommendedPlantsSerializer()  # Nest the RecommendedPlantsSerializer

    class Meta:
        model = Plant
        fields='__all__'
        read_only_fields = ['id', 'created_at', 'updated_at']

