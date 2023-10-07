from django.shortcuts import render
from rest_framework.views import APIView
from .models import Estudent
from .serializers import EstudentSerializer
from rest_framework.response import Response

class EstudenApi(APIView):
    def post(self,request):
        serializer = EstudentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        
        return Response(serializer.data)
    
    def get(self,request):
        estudent = Estudent.objects.all()
        serializer = EstudentSerializer(estudent,many=True)
        return Response(serializer.data)
