from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework.response import Response
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.test import APIClient
from poem.models import Holiday
from poem.api.serializers import HolidaySerializer


class HolidayApiTestCase(APITestCase):
    def test_get(self):
        hol_1 = Holiday.objects.create(name="name_1", description='description_1', slug='slug_1')
        hol_2 = Holiday.objects.create(name="name_2", description='description_2', slug='slug_2')
        url = reverse('holiday-list')
        response = self.client.get(url)
        serializer_data = HolidaySerializer([hol_1, hol_2], many=True).data
        self.assertEqual(status.HTTP_200_OK, response.status_code)
        self.assertEqual(serializer_data, response.data)


class TokenAuthUserProfileTestCase(APITestCase):
    def test_api_jwt(self):
        url = reverse('token_obtain_pair')
        user = User.objects.create_user(username='iko9', password='i041291ko')
        user.is_active = True
        user.save()
        client = APIClient()

        response = self.client.post(url, {'username': 'iko9', 'password': 'i041291ko'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue('access' in response.data)
        token = response.data['access']

        client.credentials(HTTP_AUTHORIZATION='Bearer ' + 'abc')
        response = client.get('/api/poem/', data={'format': 'json'})
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

        client.credentials(HTTP_AUTHORIZATION='Bearer ' + token)
        response = client.get('/api/poem/', data={'format': 'json'})
        self.assertEqual(response.status_code, status.HTTP_200_OK)