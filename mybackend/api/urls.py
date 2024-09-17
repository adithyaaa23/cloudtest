from django.urls import path
from .views import get_device

urlpatterns=[path('devices/',get_device),]