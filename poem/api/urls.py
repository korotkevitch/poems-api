from django.urls import path, re_path, include
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import PoemAPIList, PoemAPIUpdate, PoemAPIDestroy, ReviewList, ReviewDetail, ReviewCreate, UserReview


urlpatterns = [
    path('api/poem/', PoemAPIList.as_view()),
    path('api/poem/<int:pk>/', PoemAPIUpdate.as_view()),
    path('api/poemdelete/<int:pk>/', PoemAPIDestroy.as_view()),

    re_path(r'^auth/', include('djoser.urls')),
    re_path(r'^auth/', include('djoser.urls.jwt')),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    path('<int:pk>/review-create/', ReviewCreate.as_view(), name='review-create'),
    path('<int:pk>/reviews/', ReviewList.as_view(), name='review-list'),
    path('review/<int:pk>/', ReviewDetail.as_view(), name='review-detail'),

    path('reviews/', UserReview.as_view(), name='user-review-detail'),
]