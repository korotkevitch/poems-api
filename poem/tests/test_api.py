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


# class JwtSuperuserTestCase(APITestCase):
#     def setUp(self):
#         user = User.objects.create_superuser(username='iko', password='i041291ko')
#         user.save()
#         self.api_authentication()
#
#     def api_authentication(self):
#         self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
#
#     def test_jwt_authorization(self):
#         url = reverse('token_obtain_pair')
#         response = self.client.post(url, {'username': 'iko', 'password': 'i041291ko'}, format='json')
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#         self.assertTrue('access' in response.data)
#         self.assertTrue('refresh' in response.data)
#
#     def test_poem_list(self):
#         url = reverse('token_obtain_pair')
#         response = self.client.post(url, {'username': 'iko', 'password': 'i041291ko'}, format='json')
#
#         token = response.data['access']
#         self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + token)
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#
#
#         self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + 'abc')
#         response = self.client.get('/api/poem/', data={'format': 'json'})
#         self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


class SimpleJwtSuperuserPoemListCase(APITestCase):
    main_url = reverse('poem-list')

    def setUp(self):
        user = User.objects.create_superuser(username='iko', password='i041291ko')
        user.save()
        response = self.client.post('/auth/jwt/create/', data={'username': 'iko', 'password': 'i041291ko'})
        self.token = response.data['access']
        self.api_authentication()

    def api_authentication(self):
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)

    # authentication is successful
    def test_superuser_is_authenticated(self):
        response = self.client.get(self.main_url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    # authentication isn't successful
    def test_superuser_is_not_authenticated(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(self.main_url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
