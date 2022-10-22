from django.urls import path, re_path, include
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import PoemAPIList, PoemAPIUpdate, PoemAPIDestroy


urlpatterns = [
    path('api/poem/', PoemAPIList.as_view()),
    path('api/poem/<int:pk>/', PoemAPIUpdate.as_view()),
    path('api/poemdelete/<int:pk>/', PoemAPIDestroy.as_view()),

    re_path(r'^auth/', include('djoser.urls')),
    re_path(r'^auth/', include('djoser.urls.jwt')),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]