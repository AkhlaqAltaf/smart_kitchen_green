from rest_framework import viewsets
from rest_framework.permissions import AllowAny

from src.apis.garden.serializers import PlantSerializer
from src.apis.garden.models import Plant


# RECOMMENDATION NEED
from rest_framework import status
from rest_framework.generics import CreateAPIView
from rest_framework.response import Response
from rest_framework.views import APIView

from src.apis.garden.recommendation.ai_models.recommend_content_based import Prediction
from src.external.weather.main import get_weather_data



from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from .models import Plant, RecommendedPlants
from .serializers import PlantSerializer
from django.utils import timezone

class PlantAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        plants = Plant.objects.filter(user=request.user)
        serializer = PlantSerializer(plants, many=True)
        return Response(serializer.data)


    def post(self, request):
        recommended_plant_id = request.data.get('recommended_plant')
        print(recommended_plant_id)
        user = request.user

        try:
            recommended_plant = RecommendedPlants.objects.get(id=recommended_plant_id)
        except RecommendedPlants.DoesNotExist:
            return Response({"error": "Recommended plant not found."}, status=status.HTTP_404_NOT_FOUND)

        # Create a new Plant instance
        plant = Plant(
            user=user,
            recommended_plant=recommended_plant,
            planting_date=timezone.now().date(),  # Set the planting date to today
            last_watering=None,  # You can set this to None or any default value
            created_at=timezone.now(),
            updated_at=timezone.now()
        )
        plant.save()

        serializer = PlantSerializer(plant)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def put(self, request, pk):
        try:
            plant = Plant.objects.get(pk=pk, user=request.user)
        except Plant.DoesNotExist:
            return Response({"error": "Plant not found."}, status=status.HTTP_404_NOT_FOUND)

        serializer = PlantSerializer(plant, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        try:
            plant = Plant.objects.get(pk=pk, user=request.user)
            plant.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        except Plant.DoesNotExist:
            return Response({"error": "Plant not found."}, status=status.HTTP_404_NOT_FOUND)

# VERIFIED
class ProductRecommendationOnLocationAPI(APIView):

    def get(self, request, *args, **kwargs):
        latitude = self.kwargs.get('latitude')
        longitude = self.kwargs.get('longitude')
        address = self.kwargs.get('address')
        is_more = self.kwargs.get('is_more')
        is_more = bool(is_more)



        try:
            # CONVERT TO FLOAT -- ISSUE HERE
            latitude = float(latitude)
            longitude = float(longitude)

            (temperature, humidity, soil_temperature_0_to_7cm, soil_moisture_0_to_7cm, precipitation, daylight_duration) \
                = get_weather_data(latitude, longitude)

            input_data = {
                'Temperature': temperature,
                'Soil_Temperature': soil_temperature_0_to_7cm,
                'Soil_Moisture': soil_moisture_0_to_7cm,
                'Precipitation': precipitation,
                'Sunshine_Duration': daylight_duration,
                'Humid': humidity
            }

            # TODO: AI: IK
            prediction = Prediction(data=input_data,address=address,is_more=is_more)

            return Response(data=prediction.filter_predictions())

        except Exception as e:
            return Response(data={'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

