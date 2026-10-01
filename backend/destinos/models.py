from django.db import models


class Destino(models.Model):
    nombre = models.CharField(max_length=150)
    descripcion = models.TextField()
    ciudad = models.CharField(max_length=100)
    categoria = models.CharField(max_length=100)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    imagen = models.URLField(blank=True)

    def __str__(self):
        return self.nombre