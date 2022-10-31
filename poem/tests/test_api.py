from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework.response import Response
from rest_framework import status
from rest_framework.test import APITestCase
from poem.models import Holiday, Poem
from poem.api.serializers import HolidaySerializer, PoemSerializer


class HolidayApiTestCase(APITestCase):
    main_url = reverse('holiday-list')

    def test_get(self):
        hol_1 = Holiday.objects.create(name="name_1", description='description_1', slug='slug_1')
        hol_2 = Holiday.objects.create(name="name_2", description='description_2', slug='slug_2')
        response = self.client.get(self.main_url)
        serializer_data = HolidaySerializer([hol_1, hol_2], many=True).data
        self.assertEqual(status.HTTP_200_OK, response.status_code)
        self.assertEqual(serializer_data, response.data)


class SimpleJwtSuperuserPoemListCase(APITestCase):
    main_url = reverse('poem-list')

    def setUp(self):
        self.user = User.objects.create_superuser(username='iko', password='i041291ko')
        response = self.client.post('/auth/jwt/create/', data={'username': 'iko', 'password': 'i041291ko'})
        self.token = response.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)

    # authentication is successful
    def test_superuser_is_authenticated(self):
        response = self.client.get(self.main_url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # poem_1 = Poem.objects.create(title="title_1", holiday_id=="1", text='text_1', is_published=True, user.id=="1")
        # response = self.client.get(self.main_url)
        # serializer_data = PoemSerializer(poem_1).data
        # self.assertEqual(status.HTTP_200_OK, response.status_code)
        # self.assertEqual(serializer_data, response.data)

    # authentication isn't successful
    def test_superuser_is_not_authenticated(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(self.main_url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


