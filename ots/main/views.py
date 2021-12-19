from django.forms.widgets import Input
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, redirect
from django.template import loader

from .models import HotelReview, PlaceReview
from .models import ResturantReview, HotelReservation

from django.contrib.auth.decorators import login_required

from django.http import FileResponse
import io
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib.pagesizes import letter
from reportlab.lib.utils import ImageReader

from django.core.mail import send_mail
from . import forms


# Create your views here.
@login_required(login_url="/accounts/login/")
def homepage(request):
    return render(request, 'main/homepage.html')


@login_required(login_url="/accounts/login/")
def about(request):
    # return HttpResponse("About")
    return render(request, 'main/about.html')


@login_required(login_url="/account/login/")
def contact(request):
    if request.method == "POST":
        message_name = request.POST['message-name']
        message_email = request.POST['message-email']
        message_phone = request.POST['message-phone']
        message = request.POST['message-message']

        # send email
        send_mail(
            'Mail Sent By ' + message_name,  # subject
            '\n' + 'Senders Phone: ' + message_phone + '\nSenders Email: ' + message_email + ' \nMessage: ' + message,
            # message
            message_email,  # from mail
            ['rashikbuksh71@gmail.com'],  # tomail
        )
        return render(request, 'main/contact.html', {'message_name': message_name})
    else:
        return render(request, 'main/contact.html')


@login_required(login_url="/account/login/")
def hotelReview(request):
    form = forms.HotelReview()
    if request.method == 'POST':
        form = forms.HotelReview(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.HotelReview()
    return render(request, 'main/HotelReview.html', {'form': form})


@login_required(login_url="/account/login/")
def hotelReviewShow(request):
    hotelReview = HotelReview.objects.all().order_by('date')
    return render(request, 'main/HotelReviewShow.html', {'hotelReview': hotelReview})


@login_required(login_url="/account/login/")
def deleteHotelReview(request, pk):
    instance = HotelReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:hotelReviewShow')


@login_required(login_url="/account/login/")
def resturantReview(request):
    form = forms.ResturantReview()
    if request.method == 'POST':
        form = forms.ResturantReview(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.ResturantReview()
    return render(request, 'main/ResturantReview.html', {'form': form})


@login_required(login_url="/account/login/")
def resturantReviewShow(request):
    resturantReview = ResturantReview.objects.all().order_by('date')
    return render(request, 'main/ResturantReviewShow.html', {'resturantReview': resturantReview})


@login_required(login_url="/account/login/")
def deleteresturantReview(request, pk):
    instance = ResturantReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:resturantReviewShow')


@login_required(login_url="/account/login/")
def placeReview(request):
    form = forms.PlaceReview()
    if request.method == 'POST':
        form = forms.PlaceReview(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.PlaceReview()
    return render(request, 'main/PlaceReview.html', {'form': form})


@login_required(login_url="/account/login/")
def placeReviewShow(request):
    placeReview = PlaceReview.objects.all().order_by('date')
    return render(request, 'main/PlaceReviewShow.html', {'placeReview': placeReview})


@login_required(login_url="/account/login/")
def deleteplaceReview(request, pk):
    instance = PlaceReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:placeReviewShow')


@login_required(login_url="/account/login/")
def hotel_booking(request):
    hotel_booking.user_name = request.POST.get('user-name')
    hotel_booking.user_email = request.POST.get('user-email')
    hotel_booking.user_phone = request.POST.get('user-phone')
    hotel_booking.checkin_date = request.POST.get('checkin-date')
    hotel_booking.checkout_date = request.POST.get('checkout-date')
    hotel_booking.hotel_name = request.POST.get('hotel-name')
    hotel_booking.room_numbers = request.POST.get('room-numbers')
    hotel_booking.room_type = request.POST.get('room-type')

    return render(request, 'main/hotel_booking.html', {'user_name': hotel_booking.user_name, 'user_email': hotel_booking.user_email, 'user_phone': hotel_booking.user_phone, 'checkin_date': hotel_booking.checkin_date,'checkout_date': hotel_booking.checkout_date, 'hotel_name': hotel_booking.hotel_name, 'room_numbers': hotel_booking.room_numbers, 'room_type':  hotel_booking.room_type})


@login_required(login_url="/account/login/")
def hotel_bookingPdf(request):
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=letter, bottomup=0)
    textob = c.beginText()
    textob.setTextOrigin(inch, inch)
    textob.setFont("Helvetica", 14)
    logo = ImageReader('https://i.ibb.co/MPcBtHf/logo1.jpg')

    name = hotel_booking.user_name
    mail = hotel_booking.user_email
    phone = hotel_booking.user_phone
    checkin = hotel_booking.checkin_date
    checkout = hotel_booking.checkout_date
    hotel_name = hotel_booking.hotel_name
    room_number = hotel_booking.room_numbers
    room_type = hotel_booking.room_type

    hotel_reservation_instance = HotelReservation.objects.create(user_name=name, user_email=mail, user_phone=phone, checkin_date=checkin, checkout_date=checkout, hotel_name=hotel_name, room_number=room_number, room_type=room_type, user=request.user)
    hotel_reservation_instance.save()

    lines = [
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",

        "                                     Welcome to Green Travel",
        " ",
        "                           Your Reservation confirmation is below",
        " ",
        " ",
        " ",
        "        Full name: " + name,
        " ",
        "        Email: " + mail,
        " ",
        "        Phone: " + phone,
        " ",
        "        Check-in date: " + checkin,
        " ",
        "        Check-out date: " + checkout,
        " ",
        "        Hotel name: " + hotel_name,
        " ",
        "        Total number of rooms: " + room_number,
        " ",
        "        Room type: " + room_type,
        " ",
        " ",
        "",
        "                               Thank you for using Green Travel",
        "",
        "                               All right reserved by Green Travel",

    ]

    for line in lines:
        textob.textLine(line)

    c.drawImage(logo, 170, 10, mask='auto', anchor='c')
    c.drawText(textob)
    c.showPage()
    c.save()
    buf.seek(0)

    return FileResponse(buf, as_attachment=True, filename='room.pdf')
