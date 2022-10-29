from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework.response import Response
from rest_framework import status
from rest_framework.test import APITestCase
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
        u = User.objects.create_user(username='iko9', password='i041291ko')
        u.is_active = True
        u.save()

        response = self.client.post(url, {'username': 'iko9', 'password': 'i041291ko'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        # print(response.data)
        self.assertTrue('access' in response.data)
        access = response.data['access']
        print(access)

        verification_url = 127.0.0.1:8000/auth/jwt/verify/
        response = self.client.post(verification_url, {'token': access}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # resp = self.client.post(verification_url, {'token': 'abc'}, format='json')
        # self.assertEqual(resp.status_code, status.HTTP_400_BAD_REQUEST)
        #
        # client = APIClient()
        # client.credentials(HTTP_AUTHORIZATION='JWT ' + 'abc')
        # resp = client.get('/api/v1/account/', data={'format': 'json'})
        # self.assertEqual(resp.status_code, status.HTTP_401_UNAUTHORIZED)
        # client.credentials(HTTP_AUTHORIZATION='JWT ' + token)
        # resp = client.get('/api/v1/account/', data={'format': 'json'})
        # self.assertEqual(resp.status_code, status.HTTP_200_OK)