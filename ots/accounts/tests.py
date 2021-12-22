from multiprocessing.connection import Client

from django.test import SimpleTestCase, TestCase, client
from django.urls import reverse, resolve
from .models import User
import json
from .views import signup_view, login_view, logout_view, \
        activate_user


class UrlsTest(SimpleTestCase):
    def test_signup(self):
        url = reverse('accounts:signup')
        self.assertEquals(resolve(url).func, signup_view)

    def test_login(self):
        url = reverse('accounts:login')
        self.assertEquals(resolve(url).func, login_view)

    def test_logout(self):
        url = reverse('accounts:logout')
        self.assertEquals(resolve(url).func, logout_view)

    def test_activateUser(self):
        url = reverse('accounts:activate', args=['user', 'token'])
        self.assertEquals(resolve(url).func, activate_user)


class ViewTest(TestCase):
    def test_login_view_POST(self):
        response = self.client.post(reverse('accounts:login'))
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'accounts/login.html')

    def test_logout_view_POST(self):
        response = self.client.post(reverse('accounts:logout'))
        self.assertEquals(response.status_code, 302)
