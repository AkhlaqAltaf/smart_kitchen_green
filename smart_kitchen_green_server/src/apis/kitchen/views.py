from rest_framework import viewsets
from rest_framework.permissions import AllowAny

from src.apis.kitchen.serializers import ProductSerializer ,ApplianceSerializer
from src.apps.kitchen.models import Product,Appliance


class ProductApiView(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [AllowAny]


class ApplianceApiView(viewsets.ModelViewSet):
    queryset = Appliance.objects.all()
    serializer_class = ApplianceSerializer
    permission_classes = [AllowAny]
