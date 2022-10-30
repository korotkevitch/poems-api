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
        user = User.objects.create_superuser(username='iko9', password='i041291ko')
        user.is_active = True
        user.save()

        response = self.client.post(url, {'username': 'iko9', 'password': 'i041291ko'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue('access' in response.data)
        token = response.data['access']

        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + 'abc')
        response = self.client.get('/api/poem/', data={'format': 'json'})
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + token)
        response = self.client.get('/api/poem/', data={'format': 'json'})
        self.assertEqual(response.status_code, status.HTTP_200_OK)

#
# class SimpleJwtUserPoemListCase(APITestCase):
#     main_url = reverse('poem-list')
#
#     def setUp(self):
#         self.user = self.client.post('/auth/users/', data={'username': 'iko9', 'password': 'i041291ko!'})
#         response = self.client.post('/auth/jwt/create/', data={'username': 'iko9', 'password': 'i041291ko!'})
#         self.token = response.data['access']
#         self.api_authentication()
#
#     def api_authentication(self):
#         self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
#
#     # authentication is successful
#     def test_userprofile_is_authenticated(self):
#         response = self.client.get(self.main_url)
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#
#     # authentication isn't successful
#     def test_userprofile_is_not_unauthenticated(self):
#         self.client.force_authenticate(user=None)
#         response = self.client.get(self.main_url)
#         self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
