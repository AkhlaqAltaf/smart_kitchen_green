from django.urls import path
from .views import HomeView, AboutUsView, ContactUsView, ApiDocView, ApiReverse, send_notification_view

app_name = 'website'
urlpatterns = [
    path('', HomeView.as_view(), name='home'),
    path('apidoc', ApiDocView.as_view(), name='apidoc'),
    path('contactus', ContactUsView.as_view(), name='contactus'),
    path('aboutus', AboutUsView.as_view(), name='aboutus'),
    path('api', ApiReverse.as_view(), name='api'),
    path('send-notification/', send_notification_view, name='send_notification'),

]
