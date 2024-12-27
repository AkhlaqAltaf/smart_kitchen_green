from rest_framework import routers

from src.apis.garden.views import PlantAPIView, ProductRecommendationOnLocationAPI

from django.urls import  path, include

app_name='garden'




urlpatterns=[
    path('plants/', PlantAPIView.as_view(), name='plant-list'),  # For listing and creating plants
    path('plants/<int:pk>/', PlantAPIView.as_view(), name='plant-detail'),
    path(
        'location/<str:longitude>/<str:latitude>/<str:address>/<str:is_more>/',
        ProductRecommendationOnLocationAPI.as_view(), name='recommendation-on-location'
    ),

]