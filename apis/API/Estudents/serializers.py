from rest_framework import serializers
from .models import Estudent

class EstudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Estudent
        fields = ('name','grade','prom')