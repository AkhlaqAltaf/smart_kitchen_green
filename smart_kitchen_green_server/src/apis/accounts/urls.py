from django.urls import path, re_path

from dj_rest_auth.views import (
    LogoutView, PasswordChangeView ,LoginView ,GenericAPIView
)
from .views import (
    UserRetrieveChangeAPIView, CustomLoginView, UserCreateView
)

app_name = 'accounts'
urlpatterns = [
    path('register/', UserCreateView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='rest_login'),
    path('logout/', LogoutView.as_view(), name='rest_logout'),
    path('password/change/', PasswordChangeView.as_view(), name='rest_password_change'),
]
