from rest_framework.routers import DefaultRouter
from .views import DestinoViewSet


router = DefaultRouter()

router.register(
    r'destinos',
    DestinoViewSet,
    basename='destino'
)

urlpatterns = router.urls