from django.urls import include, path
from rest_framework import routers

from src.apis.kitchen.views import ProductApiView, CreateApplianceView

app_name = 'kitchen'



route = routers.DefaultRouter()

route.register(r'product', ProductApiView)

urlpatterns = [
    path('', include(route.urls)),
    path('appliance/',CreateApplianceView.as_view(), name='appliance'),

]
