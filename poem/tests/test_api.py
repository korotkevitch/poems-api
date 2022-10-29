from django.contrib.auth.models import User
from django.urls import reverse

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


# class RegisterTestCase(APITestCase):
#
#     def test_register(self):
#         data = {
#             "username": "testcase",
#             "email": "testcase@example.com",
#             "password": "NewPassword@123",
#             "password2": "NewPassword@123"
#         }
#         response = self.client.post(reverse('register'), data)
#         self.assertEqual(response.status_code, status.HTTP_201_CREATED)