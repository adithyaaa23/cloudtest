from django.shortcuts import render
from django.http import JsonResponse
# Create your views here.
from .models import Device
def get_device(request):
    devices=list(Device.objects.values())
    return JsonResponse(devices,safe=False)