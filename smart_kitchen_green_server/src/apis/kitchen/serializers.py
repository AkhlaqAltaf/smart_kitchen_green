from rest_framework import  serializers
from src.apis.kitchen.models import Product ,Appliance


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id', 'user', 'name', 'quantity', 'barcode','expiry_date','image', 'type', 'appliance_time', 'created_at', 'updated_at']
        read_only_fields = ['id', 'created_at', 'updated_at','user']


class ApplianceSerializer(serializers.ModelSerializer):

    class Meta:
        model = Appliance
        fields = ['product','take_time']
