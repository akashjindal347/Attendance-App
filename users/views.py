from django.shortcuts import render,redirect
from .forms import RegistrationForm,AttendanceForm

from django.contrib.auth.decorators import login_required

# Create your views here.

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            
            form.save()
            return redirect('home')
    else:
    	form = RegistrationForm()
    
    return render(request,'users/signup.html',{'form': form})



@login_required
def profile(request):
        return render(request, 'users/profile.html',{})


def attendance(request):
    if request.method == 'POST':
        
        attendance_form = AttendanceForm(request.POST)
        
        if attendance_form.is_valid():
                attendance = attendance_form.save(commit=False)
                attendance.user = request.user
                
                
                attendance.save()
                return redirect('marked')
            
    else:
        attendance_form = AttendanceForm()
    
    return render(request,'users/attendanceForm.html',{'form': attendance_form})

        












