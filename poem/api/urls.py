from django.urls import path, re_path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import PoemAPIList, PoemAPICreate, PoemAPIUpdate, PoemAPIDestroy, ReviewList, ReviewDetail, ReviewCreate, UserReview, \
    RatingReview, HolidayListVS, AuthorListVS


router = DefaultRouter()
router.register('holiday', HolidayListVS)
router.register('author', AuthorListVS)

urlpatterns = [
    path('api/poem/', PoemAPIList.as_view(), name='poem-list'),
    path('api/poem-create/', PoemAPICreate.as_view(), name='poem-create'),
    path('api/poem/<int:pk>/', PoemAPIUpdate.as_view(), name='poem-update'),
    path('api/poem-delete/<int:pk>/', PoemAPIDestroy.as_view(), name='poem-delete'),

    path('', include(router.urls)),

    re_path(r'^auth/', include('djoser.urls')),
    re_path(r'^auth/', include('djoser.urls.jwt')),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    path('<int:pk>/review-create/', ReviewCreate.as_view(), name='review-create'),
    path('<int:pk>/reviews/', ReviewList.as_view(), name='review-list'),
    path('review/<int:pk>/', ReviewDetail.as_view(), name='review-detail'),

    path('reviews/<int:rating>/', RatingReview.as_view(), name='rating-review-detail'),  # /reviews/4/ - with rating 4
    path('reviews/', UserReview.as_view(), name='user-review-detail'),  # /reviews/?username=admin - reviews from admin
]