from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required


@login_required(login_url="/accounts/login/")
def homepage(request):
    return redirect('articles:list')



