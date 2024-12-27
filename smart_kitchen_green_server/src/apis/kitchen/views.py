from rest_framework import viewsets, status
from rest_framework.permissions import AllowAny , IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from src.apis.kitchen.serializers import ProductSerializer ,ApplianceSerializer
from src.apis.kitchen.models import Product,Appliance


class ProductApiView(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Product.objects.filter(user=user)

    def create(self, request, *args, **kwargs):
        user = request.user
        data = request.data

        if isinstance(data, list):
            # Handling multiple product creation
            serializers = [self.get_serializer(data=item) for item in data]
            for serializer in serializers:
                serializer.is_valid(raise_exception=True)
                serializer.save(user=user)
            return Response([serializer.data for serializer in serializers], status=status.HTTP_201_CREATED)
        else:
            # Handling single product creation
            serializer = self.get_serializer(data=data)
            serializer.is_valid(raise_exception=True)
            serializer.save(user=user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)

class CreateApplianceView(APIView):
    def post(self, request):
        # Extract product ID and take_time from request data
        product_id = request.data.get('product')
        take_time = request.data.get('mints')

        if not product_id:
            return Response({"error": "Product ID is required."}, status=status.HTTP_400_BAD_REQUEST)

        # Get the authenticated user
        user = request.user
        print("USER : ", user.id)

        try:
            # Fetch the product from the database
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            return Response({"error": "Product not found."}, status=status.HTTP_404_NOT_FOUND)

        # Create an instance of the Appliance model
        appliance_data = {
            "product": product.id,  # product as ID since it's a ForeignKey
            "take_time": take_time,
        }

        serializer = ApplianceSerializer(data=appliance_data)

        if serializer.is_valid():
            # Save the serializer with the user and product ForeignKey objects
            appliance = serializer.save(user=user, product=product)


            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)