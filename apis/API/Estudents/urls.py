from django.urls import path
from .views import EstudenApi

urlpatterns = [
    path('estudents/', EstudenApi.as_view())
]