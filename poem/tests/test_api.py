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


    def test_author_create_is_not_authorized(self):
        self.client.force_authenticate(user=None)
        response = self.client.post(reverse('author-list'), data={'first_name': 'Igor', 'last_name': 'Korotkevitch', 'slug': 'korotkevitch'})
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


    def test_author_list_is_user(self):
        response = self.client.get(reverse('author-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_author_list_is_not_authorized(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(reverse('author-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_author_detail_is_user(self):
        response = self.client.get(reverse('author-detail', args=(self.author.id,)))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(models.Author.objects.count(), 1)
        self.assertEqual(models.Author.objects.get().first_name, 'Igor3')


    def test_author_detail_is_not_authorized(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(reverse('author-detail', args=(self.author.id,)))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(models.Author.objects.count(), 1)
        self.assertEqual(models.Author.objects.get().first_name, 'Igor3')


class UserPoemApiTestCase(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='iko5', password='iko5@123.com')
        response = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko5', 'password': 'iko5@123.com'})
        self.token = response.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        self.author = models.Author.objects.create(first_name='Igor5', last_name='Korotkevitch5', slug='korotkevitch5')
        self.holiday = models.Holiday.objects.create(name="name_3", description="description_3", slug="slug_3")
        self.poem = models.Poem.objects.create(title="Всем дням...", text="Всем дням особо", is_published=True,
                                               holiday=self.holiday, author=self.author, user=self.user)

    def test_poem_list_is_user(self):
        response = self.client.get(reverse('poem-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_poem_list_is_not_authorized(self):
        self.client.force_authenticate(user=None)
        response = self.client.get(reverse('poem-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)


    def test_poem_create_is_user(self):
        data = {
            "title": "Всем",
            "text": "Всем дням особо",
            "is_published": True,
            "holiday": self.holiday.id,
            "author": self.author.id,
            "user": self.user.id
        }

        response = self.client.post(reverse('poem-create'), data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)


    def test_poem_create_is_not_authorized(self):
        self.client.force_authenticate(user=None)
        response = self.client.post(reverse('poem-create'))
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


    def test_poem_update_is_user(self):
        data = {
            "title": "Всем",
            "text": "Всем дням особо",
            "is_published": True,
            "holiday": self.holiday.id,
            "author": self.author.id,
            "user": self.user.id
        }
        response = self.client.put(reverse('poem-update', args=(self.poem.id,)), data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    '''
    Проверяем, сможет ли редактировать стихи не тот, кто их разместил (не user, а user2).
    '''
    def test_poem_update_is_user2(self):
        self.user2 = User.objects.create_user(username='iko50', password='iko50@123.com')
        response2 = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko50', 'password': 'iko50@123.com'})
        self.token2 = response2.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token2)

        data = {
            "title": "Всем",
            "text": "Всем дням особо",
            "is_published": True,
            "holiday": self.holiday.id,
            "author": self.author.id,
            "user": self.user2.id
        }
        response2 = self.client.put(reverse('poem-update', args=(self.poem.id,)), data)
        self.assertEqual(response2.status_code, status.HTTP_403_FORBIDDEN)


    def test_poem_update_is_not_authorized(self):
        data = {
            "title": "Всем",
            "text": "Всем дням особо",
            "is_published": True,
            "holiday": self.holiday.id,
            "author": self.author.id,
            "user": self.user.id
        }
        self.client.force_authenticate(user=None)
        response = self.client.put(reverse('poem-update', args=(self.poem.id,)), data)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


    def test_poem_ind_delete_is_user(self):
        response = self.client.delete(reverse('poem-delete', args=(self.poem.id,)))
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)


    def test_poem_ind_delete_is_not_authorized(self):
        self.client.force_authenticate(user=None)
        response = self.client.delete(reverse('poem-delete', args=(self.poem.id,)))
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    '''
    Проверяем, сможет ли удалить стихи не тот, кто их разместил (не user, а user2).
    '''
    def test_poem_ind_delete_is_user2(self):
        self.user2 = User.objects.create_user(username='iko50', password='iko50@123.com')
        response2 = self.client.post(reverse('token_obtain_pair'),
                                     data={'username': 'iko50', 'password': 'iko50@123.com'})
        self.token2 = response2.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token2)
        response2 = self.client.delete(reverse('poem-delete', args=(self.poem.id,)))
        self.assertEqual(response2.status_code, status.HTTP_403_FORBIDDEN)


class ReviewTestCase(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='iko', password='iko@123.com')
        response = self.client.post(reverse('token_obtain_pair'), data={'username': 'iko', 'password': 'iko@123.com'})
        self.token = response.data['access']
        self.client.credentials(HTTP_AUTHORIZATION='Bearer ' + self.token)
        self.author = models.Author.objects.create(first_name='Igor7', last_name='Korotkevitch7', slug='korotkevitch7')
        self.holiday = models.Holiday.objects.create(name="name_4", description="description_4", slug="slug_4")
        self.poem = models.Poem.objects.create(title="Всем дням...", text="Всем дням особо...", is_published=True,
                                               holiday=self.holiday, author=self.author, user=self.user)


    def test_review_criate_is_user(self):
        data = {
            "review_user": self.user.id,
            "rating": 4,
            "description": "Классные стихи",
            "active": True
        }
        response = self.client.post(reverse('review-create', args=(self.poem.id,)), data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
