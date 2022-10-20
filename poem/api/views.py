from rest_framework import generics
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAdminUser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import GenericViewSet

from .models import Poem, Holiday
from .permissions import IsAdminOrReadOnly, IsOwnerOrReadOnly
from .serializers import PoemSerializer


class PoemAPIList(generics.ListCreateAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    # permission_classes = (IsAuthenticatedOrReadOnly, )


class PoemAPIUpdate(generics.RetrieveUpdateAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = (IsOwnerOrReadOnly, )


class PoemAPIDestroy(generics.RetrieveDestroyAPIView):
    queryset = Poem.objects.all()
    serializer_class = PoemSerializer
    permission_classes = (IsAdminOrReadOnly, )