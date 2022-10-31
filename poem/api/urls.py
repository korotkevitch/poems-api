from django.urls import path, re_path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import PoemAPIList, PoemAPIUpdate, PoemAPIDestroy, ReviewList, ReviewDetail, ReviewCreate, UserReview, \
    RatingReview, HolidayListVS


router = DefaultRouter()
router.register('holiday', HolidayListVS)

urlpatterns = [
    path('api/poem/', PoemAPIList.as_view(), name='poem-list'),
    path('api/poem/<int:pk>/', PoemAPIUpdate.as_view()),
    path('api/poemdelete/<int:pk>/', PoemAPIDestroy.as_view()),

    path('', include(router.urls)),

    re_path(r'^auth/', include('djoser.urls')),
    re_path(r'^auth/', include('djoser.urls.jwt')),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    path('<int:pk>/review-create/', ReviewCreate.as_view(), name='review-create'),
    path('<int:pk>/reviews/', ReviewList.as_view(), name='review-list'),
    path('review/<int:pk>/', ReviewDetail.as_view(), name='review-detail'),

    path('reviews/<int:rating>/', RatingReview.as_view(), name='rating-review-detail'),
    path('reviews/', UserReview.as_view(), name='user-review-detail'),
]