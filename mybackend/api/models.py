from django.db import models

# Create your models here.
class Device(models.Model):
    name=models.CharField(max_length=100)
    location=models.CharField(max_length=100)
    
    def __str__(self) -> str:
        return self.name