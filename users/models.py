from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class Attendance(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)

    rollNo =models.IntegerField()
    group = models.CharField(max_length= 6)

    def __str__(self):
        return self.user.username

