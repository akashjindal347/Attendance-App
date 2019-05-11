from django.urls import path
from .views import HomePageView,Marked

urlpatterns = [
    path('',HomePageView.as_view(),name = 'home' ),
    path('marked',Marked.as_view(),name = 'marked' ),
]