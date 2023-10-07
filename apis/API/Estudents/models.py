from django.db import models

class Estudent(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    grade = models.CharField(max_length=100)
    prom = models.IntegerField()
    
    def __str__(self):
        return self.name