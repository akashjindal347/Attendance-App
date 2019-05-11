from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Attendance

class RegistrationForm(UserCreationForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']


class AttendanceForm(forms.ModelForm):
    
    class Meta:
        model = Attendance
        fields = ['rollNo','group']