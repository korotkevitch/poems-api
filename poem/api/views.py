from rest_framework import generics
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAdminUser, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import GenericViewSet

from poem.models import Poem, Author, Holiday
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from .permissions import IsAdminOrReadOnly, IsOwnerOrReadOnly
from .serializers import PoemSerializer


class PoemAPIList(generics.ListCreateAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = [IsAdminOrReadOnly]


class PoemAPIUpdate(generics.RetrieveUpdateAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = [IsAuthenticated]


class PoemAPIDestroy(generics.RetrieveDestroyAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = [IsAdminOrReadOnly]