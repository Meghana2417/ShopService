# shop_service/urls.py (main project urls.py excerpt)
#from django.contrib import admin
#from django.urls import path, include

#urlpatterns = [
 #   path('admin/', admin.site.urls),
  #  path('api/', include('shops.urls')),  # Mount the shops API under /api/
#]
# shop_service/urls.py

from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse

def home(request):
    return HttpResponse("Shop Service is running!")

urlpatterns = [
    path("", home),                        #  Homepage for /
    path("admin/", admin.site.urls),
    path("api/", include("shops.urls")),   # API routes
]

