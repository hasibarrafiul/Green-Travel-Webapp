from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import login, logout
from django.contrib import messages
from validate_email import validate_email
from .models import User
# Create your views here.


def signup_view(request):
    if request.method == 'POST':
        context = {'has_error': False, 'data': request.POST}
        email = request.POST.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')

        if len(password)<6:
            messages.add_message(request, messages.ERROR, 'Password should be at least 6 character')
            context['has_error']=True

        if password != password2:
            messages.add_message(request, messages.ERROR, 'Passwords should be same')
            context['has_error'] = True

        if not validate_email(email):
            messages.add_message(request, messages.ERROR, 'Email not valid')
            context['has_error'] = True

        if not username:
            messages.add_message(request, messages.ERROR, 'Username is required')
            context['has_error'] = True

        if User.objects.filter(username=username).exists():
            messages.add_message(request, messages.ERROR, 'Username already exists')
            context['has_error'] = True

        if User.objects.filter(email=email).exists():
            messages.add_message(request, messages.ERROR, 'Email already exists')
            context['has_error'] = True

        if context['has_error']:
            return render(request, 'accounts/signup.html', context)

        user=User.objects.create_user(username=username, email=email)
        user.set_password(password)
        user.save()

        messages.add_message(request, messages.ERROR, 'Account Created')
        messages.add_message(request, messages.ERROR, 'You can login now')
        return redirect('../login/')

    return render(request, 'accounts/signup.html')


def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            if 'next' in request.POST:
                return redirect(request.POST.get("next"))
            else:
                return redirect('articles:list')
        else:
            messages.info(request,'Username or Password is incorrect')

    else:
        form = AuthenticationForm()
    return render(request, 'accounts/login.html', {'form': form})


def logout_view(request):
    if request.method == 'POST':
        logout(request)
        return redirect('articles:list')
