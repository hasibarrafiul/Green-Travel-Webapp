from django.conf.urls import url
from django.urls import path
from . import views

app_name = 'accounts'

urlpatterns = [
    url(r'^signup/$', views.signup_view, name="signup"),
    url(r'^login/', views.login_view, name="login"),
    url(r'^logout/$', views.logout_view, name="logout"),
    path('activate-user/<uidb64>/<token>',
         views.activate_user, name='activate'),
    url(r'^$', views.login_view, name="Home"),
]
