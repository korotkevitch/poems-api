from rest_framework import generics
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAdminUser, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import GenericViewSet
from rest_framework.throttling import UserRateThrottle, AnonRateThrottle, ScopedRateThrottle
from rest_framework import filters

from django_filters.rest_framework import DjangoFilterBackend
from poem.models import Poem, Author, Holiday, Review
from rest_framework.exceptions import ValidationError
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from .permissions import IsAdminOrReadOnly, IsOwnerOrReadOnly, IsReviewUserOrReadOnly
from .serializers import PoemSerializer, ReviewSerializer, HolidaySerializer
from .throttling import ReviewCreateThrottle, ReviewListThrottle
from .pagination import PoemPagination


class HolidayAPIList(generics.ListCreateAPIView):
    queryset = Holiday.objects.all()
    serializer_class = HolidaySerializer


class PoemAPIList(generics.ListCreateAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = [IsAdminUser]
    pagination_class = PoemPagination


class PoemAPIUpdate(generics.RetrieveUpdateAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = [IsAdminUser]


class PoemAPIDestroy(generics.RetrieveDestroyAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = [IsAdminUser]


class RatingReview(generics.ListAPIView):
    serializer_class = ReviewSerializer
    permission_classes = [IsAuthenticated]
    throttle_classes = [ReviewListThrottle, AnonRateThrottle]

    def get_queryset(self):
        rating = self.kwargs['rating']
        return Review.objects.filter(rating=rating)


class UserReview(generics.ListAPIView):
    serializer_class = ReviewSerializer
    permission_classes = [IsAuthenticated]
    throttle_classes = [ReviewListThrottle, AnonRateThrottle]

    def get_queryset(self):
        username = self.request.query_params.get('username', None)  # параметры записываются в URL
        # username = self.kwargs['username']  для http://127.0.0.1:8000/reviews/iko/
        return Review.objects.filter(review_user__username=username)  # для http://127.0.0.1:8000/reviews/?username=iko


class ReviewCreate(generics.CreateAPIView):
    serializer_class = ReviewSerializer
    permission_classes = [IsAuthenticated]
    throttle_classes = [ReviewCreateThrottle]

    def get_queryset(self):
        return Review.objects.all()

    def perform_create(self, serializer):
        pk = self.kwargs.get('pk')
        poem = Poem.objects.get(pk=pk)

        review_user = self.request.user
        review_queryset = Review.objects.filter(poem=poem, review_user=review_user)

        if review_queryset.exists():
            raise ValidationError("Вы уже оценивали это стихотворение!")

        if poem.number_rating == 0:
            poem.avg_rating = serializer.validated_data['rating']
        else:
            poem.avg_rating = (poem.avg_rating + serializer.validated_data['rating'])/2

        poem.number_rating = poem.number_rating + 1
        poem.save()

        serializer.save(poem=poem, review_user=review_user)


class ReviewList(generics.ListAPIView):
    # queryset = Review.objects.all()
    serializer_class = ReviewSerializer
    permission_classes = [IsAuthenticated]
    throttle_classes = [ReviewListThrottle, AnonRateThrottle]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['review_user__username', 'active']

    def get_queryset(self):
        pk = self.kwargs['pk']
        return Review.objects.filter(poem=pk)


class ReviewDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer
    permission_classes = [IsReviewUserOrReadOnly]
    throttle_classes = [ScopedRateThrottle, AnonRateThrottle]
    throttle_scope = 'review-detail'