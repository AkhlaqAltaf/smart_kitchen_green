from rest_framework import viewsets
from rest_framework.permissions import AllowAny

from src.apis.garden.serializers import PlantSerializer
from src.apps.garden.models import Plant


class PlantApiView(viewsets.ModelViewSet):
    queryset = Plant.objects.all()
    serializer_class = PlantSerializer
    permission_classes = [AllowAny]
