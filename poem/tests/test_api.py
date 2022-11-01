from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework.response import Response
from rest_framework import status
from rest_framework.test import APITestCase
from poem.models import Holiday, Poem, Author
from poem.api.serializers import HolidaySerializer, PoemSerializer, AuthorSerializer
from poem import models


class HolidayApiTestCase(APITestCase):

    def setUp(self):
        self.user = User.objects.create_superuser(username='iko', password='iko@123.com')
        response = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko', 'password': 'iko@123.com'})
        self.token = response.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        self.holiday = models.Holiday.objects.create(name="name_1", description="description_1", slug="slug_1")

    def test_holiday_create(self):
        data = {
            'name': "name_2",
            'description': 'description_2',
            'slug': 'slug_2'}
        response = self.client.post(reverse('holiday-list'), data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_holiday_list(self):
        response = self.client.get(reverse('holiday-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_holiday_detail(self):
        response = self.client.get(reverse('holiday-detail', args=(self.holiday.id,)))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(models.Holiday.objects.count(), 1)
        self.assertEqual(models.Holiday.objects.get().name, 'name_1')

# authenticated superuser
class SuperuserAuthorApiTestCase(APITestCase):
    def setUp(self):
        self.user = User.objects.create_superuser(username='iko', password='iko@123.com')
        response = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko', 'password': 'iko@123.com'})
        self.token = response.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        self.author = models.Author.objects.create(first_name='Igor2', last_name='Korotkevitch2', slug='korotkevitch2')

    def test_author_create_is_superadmin(self):
        response = self.client.post(reverse('author-list'), data={'first_name': 'Igor', 'last_name': 'Korotkevitch', 'slug': 'korotkevitch'})
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)


    def test_author_list_is_superadmin(self):
        response = self.client.get(reverse('author-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_author_detail_is_superadmin(self):
        response = self.client.get(reverse('author-detail', args=(self.author.id,)))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(models.Author.objects.count(), 1)
        self.assertEqual(models.Author.objects.get().first_name, 'Igor2')

# authenticated not superuser and unauthenticated
class UserAuthorApiTestCase(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='iko', password='iko@123.com')
        response = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko', 'password': 'iko@123.com'})
        self.token = response.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        self.author = models.Author.objects.create(first_name='Igor3', last_name='Korotkevitch3', slug='korotkevitch3')


    def test_author_create_is_user(self):
        response = self.client.post(reverse('author-list'), data={'first_name': 'Igor4', 'last_name': 'Korotkevitch4', 'slug': 'korotkevitch4'})
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)


    def test_author_create_is_not_authotized(self):
        self.client.force_authenticate(user=None)
        response = self.client.post(reverse('author-list'), data={'first_name': 'Igor', 'last_name': 'Korotkevitch', 'slug': 'korotkevitch'})
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


    def test_author_list_is_user(self):
        response = self.client.get(reverse('author-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_author_list_is_not_authotized(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(reverse('author-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_author_detail_is_user(self):
        response = self.client.get(reverse('author-detail', args=(self.author.id,)))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(models.Author.objects.count(), 1)
        self.assertEqual(models.Author.objects.get().first_name, 'Igor3')


    def test_author_detail_is_not_authotized(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(reverse('author-detail', args=(self.author.id,)))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(models.Author.objects.count(), 1)
        self.assertEqual(models.Author.objects.get().first_name, 'Igor3')


# class PoemApiTestCase(APITestCase):
#     main_url = reverse('poem-list')
#
#     def setUp(self):
#         self.user = User.objects.create_superuser(username='iko', password='iko@123.com')
#         response = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko', 'password': 'iko@123.com'})
#         self.token = response.data['access']
#         self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
#
#     # authentication is successful
#     def test_superuser_is_authenticated(self):
#         response = self.client.get(self.main_url)
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#
#
#     # authentication isn't successful
#     def test_superuser_is_not_authenticated(self):
#         self.client.force_authenticate(user=None)
#         response = self.client.get(self.main_url)
#         self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


