from rest_framework import routers

from src.apis.garden.views import PlantApiView

from django.urls import  path, include

app_name='garden'
route = routers.DefaultRouter()

route.register(r'plant',PlantApiView)

urlpatterns=[

    path('',include(route.urls)),

]