from PIL import Image
from django.forms.widgets import Input
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, redirect
from django.template import loader
from django.urls import reverse

from .models import HotelReview, PlaceReview, RoomModel, Place, ResturantInfo, userProfile, chat
from .models import ResturantReview, HotelReservation, chatForumMessages, wishlist, userBlog, appReview

from django.contrib.auth.decorators import login_required

from django.http import FileResponse
import io
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib.pagesizes import letter
from reportlab.lib.utils import ImageReader

from django.core.mail import send_mail
from . import forms


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
def deleteHotelReview(request, pk):
    instance = HotelReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:hotel_page')


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
def deleteresturantReview(request, pk):
    instance = ResturantReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:resturantList')


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
def deleteplaceReview(request, pk):
    instance = PlaceReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:placelist')


@login_required(login_url="/account/login/")
def hotel_bookingPdf(request):
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=letter, bottomup=0)
    textob = c.beginText()
    textob.setTextOrigin(inch, inch)
    textob.setFont("Helvetica", 14)
    logo = ImageReader('https://i.ibb.co/MPcBtHf/logo1.jpg')

    name = reservationnew.user_name
    mail = reservationnew.user_email
    phone = reservationnew.user_phone
    checkin = reservationnew.checkin_date
    checkout = reservationnew.checkout_date
    hotel_name = reservationnew.hotel_name
    room_number = reservationnew.room_numbers
    room_type = reservationnew.room_type

    hotel_reservation_instance = HotelReservation.objects.create(user_name=name, user_email=mail, user_phone=phone,
                                                                 checkin_date=checkin, checkout_date=checkout,
                                                                 hotel_name=hotel_name, room_number=room_number,
                                                                 room_type=room_type, user=request.user)
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


@login_required(login_url="/account/login/")
def RoomShow(request):
    hotelReview = HotelReview.objects.all().order_by('date')
    roomModel = RoomModel.objects.all().order_by('slug')
    profile = userProfile.objects.all()
    context = {}
    hotel_name = request.POST.get('hotel-name')
    context['hotel_name'] = hotel_name
    context['roomModel'] = roomModel
    context['profile'] = profile

    context['hotelReview'] = hotelReview

    hotel = hotel_name.split('_')
    mylist = ' '.join(hotel)
    context['mylist'] = mylist

    return render(request, 'main/HotelRoom.html', context)


@login_required(login_url="/account/login/")
def hotel_page(request):
    return render(request, 'main/HotelPage.html')


def placelist(request):
    return render(request, 'main/placelist.html')


def place(request):
    placeReview = PlaceReview.objects.all().order_by('date')
    place_show = Place.objects.all().order_by('name')
    profile = userProfile.objects.all()

    context = {}
    place_name = request.POST.get('hotel-name')
    context['place_name'] = place_name
    context['place_show'] = place_show
    context['profile'] = profile
    context['placeReview'] = placeReview

    return render(request, 'main/place.html', context)


def resturantList(request):
    return render(request, 'main/ResturantList.html')


def resturantShow(request):
    resturantReview = ResturantReview.objects.all().order_by('date')
    resturant_show = ResturantInfo.objects.all().order_by('name')
    profile = userProfile.objects.all()
    context = {}
    place_name = request.POST.get('hotel-name')
    context['resturant_name'] = place_name
    context['resturant_show'] = resturant_show
    context['profile'] = profile

    context['resturantReview'] = resturantReview
    return render(request, 'main/ResturantShow.html', context)


@login_required(login_url="/account/login/")
def culturalfood(request):
    return render(request, 'main/culturalfood.html')


@login_required(login_url="/account/login/")
def updateUserProfile(request, pk):
    instance = userProfile.objects.get(id=pk)
    instance.save()
    updateUserProfile.primaryKey = pk
    return redirect('articles:user_profile')


@login_required(login_url="/account/login/")
def UserProfile(request):
    primaryKey = request.POST.get('primaryKey')
    if primaryKey is None:
        primaryKey = 1
    instance = userProfile.objects.get(id=primaryKey)
    UserProfile.user_name = request.POST.get('user_name')
    UserProfile.phone = request.POST.get('phone_number')
    UserProfile.address = request.POST.get('address')
    UserProfile.bio = request.POST.get('bio')
    UserProfile.image = request.FILES.get('image')

    if UserProfile.user_name is not None and UserProfile.user_name != '':
        instance.user_name = UserProfile.user_name

    if UserProfile.phone is not None and UserProfile.phone != '':
        instance.user_phone = UserProfile.phone

    if UserProfile.address is not None and UserProfile.address != '':
        instance.user_address = UserProfile.address

    if UserProfile.bio is not None and UserProfile.bio!= '':
        instance.bio = UserProfile.bio

    if UserProfile.image is not None:
        instance.user_image = UserProfile.image
    instance.save()

    profile = userProfile.objects.all()
    profile2 = userProfile.objects.filter(user=request.user).first()
    b = ''
    if profile2 is None:
        b = 'NoData'

    context = {}
    context['profile'] = profile
    context['booli'] = b
    context['name'] = UserProfile.user_name
    context['phone'] = UserProfile.phone
    context['address'] = UserProfile.address
    context['bio'] = UserProfile.bio
    context['image'] = UserProfile.image

    userBookedHotels = HotelReservation.objects.filter(user=request.user)
    context['userBookedHotels'] = userBookedHotels

    return render(request, 'main/user_profile.html', context)


@login_required(login_url="/account/login/")
def createProfile(request):
    form = forms.UserProfile()
    if request.method == 'POST':
        form = forms.UserProfile(request.POST, request.FILES)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.UserProfile()
    return render(request, 'main/createprofile.html', {'form': form})


@login_required(login_url="/account/login/")
def reservationnew(request):
    reservationnew.user_name = request.POST.get('user-name')
    reservationnew.user_email = request.POST.get('user-email')
    reservationnew.user_phone = request.POST.get('user-phone')
    reservationnew.checkin_date = request.POST.get('checkin-date')
    reservationnew.checkout_date = request.POST.get('checkout-date')
    reservationnew.hotel_name = request.POST.get('hotel-name')
    reservationnew.room_numbers = request.POST.get('room-numbers')
    reservationnew.room_type = request.POST.get('room-type')

    return render(request, 'main/reservationnew.html',
                  {'user_name': reservationnew.user_name, 'user_email': reservationnew.user_email,
                   'user_phone': reservationnew.user_phone, 'checkin_date': reservationnew.checkin_date,
                   'checkout_date': reservationnew.checkout_date, 'hotel_name': reservationnew.hotel_name,
                   'room_numbers': reservationnew.room_numbers, 'room_type': reservationnew.room_type})


@login_required(login_url="/account/login/")
def directmessage(request):
    userName = userProfile.objects.all()
    Chat = chat.objects.all().order_by('-date')
    context = {}
    context['chat'] = Chat
    context['userName'] = userName
    return render(request, 'main/directMessage.html', context)


@login_required(login_url="/account/login/")
def sentmessage(request):
    form = forms.chatForm()
    if request.method == 'POST':
        form = forms.chatForm(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.from_user = request.user
            instance.save()
            url = reverse('articles:direct_message')
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(url)
    else:
        form = forms.chatForm()
    return render(request, 'main/messageSend.html', {'form': form})


@login_required(login_url="/account/login/")
def chatForum(request):
    form = forms.chatForumForm()
    if request.method == 'POST':
        form = forms.chatForumForm(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.message_user = request.user
            instance.save()
            return HttpResponseRedirect(request.path_info)
    else:
        form = forms.chatForumForm()

    forum = chatForumMessages.objects.all().order_by('-date')
    context = {}
    context['forum'] = forum
    context['form'] = form
    return render(request, 'main/chatForum.html', context)


@login_required(login_url="/account/login/")
def wishList(request):
    form = forms.wishlistForm()
    if request.method == 'POST':
        form = forms.wishlistForm(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            return HttpResponseRedirect(request.path_info)
    else:
        form = forms.wishlistForm()

    WishList = wishlist.objects.all().order_by('-date')
    context = {}
    context['WishList'] = WishList
    context['form'] = form
    return render(request, 'main/wishlist.html', context)


@login_required(login_url="/account/login/")
def deletewishlist(request, pk):
    instance = wishlist.objects.get(id=pk)
    instance.delete()
    return redirect('articles:wishlist')


@login_required(login_url="/account/login/")
def giveOffer(request):
    reservation = HotelReservation.objects.filter(user=request.user)
    count = 0
    for i in reservation:
        count += 1

    context = {}
    context['offer'] = '0'
    if 3 <= count < 5:
        context['offer'] = '30'
    elif 5 <= count < 10:
        context['offer'] = '40'
    elif count >= 10:
        context['offer'] = '50'
    return render(request, 'main/offers.html', context)


@login_required(login_url="/account/login/")
def resturantsearch(request):
    if request.method == 'POST':
        search = request.POST['resturant-search']
        context = {}
        context['resturantsearch'] = search
        resturant = ResturantInfo.objects.filter(name__icontains=search)
        context['resturant'] = resturant
    return render(request, 'main/resturantsearch.html', context)


@login_required(login_url="/account/login/")
def placesearch(request):
    if request.method == 'POST':
        search = request.POST['place-search']
        context = {}
        context['placesearch'] = search
        place = Place.objects.filter(name__icontains=search)
        context['place'] = place
    return render(request, 'main/placesearch.html', context)


@login_required(login_url="/account/login/")
def hotelsearch(request):
    if request.method == 'POST':
        search = request.POST['hotel-search']
        search1 = search.split(' ')
        search2 = ('_').join(search1)
        context = {}
        context['hotelsearch'] = search
        roomModel = RoomModel.objects.filter(slug__icontains=search2)
        context['roomModel'] = roomModel
    return render(request, 'main/hotelsearch.html', context)


@login_required(login_url="/account/login/")
def blogList(request):
    blogs = userBlog.objects.all().order_by('-date')
    context = {}
    context['blogs'] = blogs
    return render(request, 'main/BlogLists.html', context)


@login_required(login_url="/account/login/")
def blogPage(request, pk):
    if pk is None:
        blog = userBlog.objects.filter(id=1)
    else:
        blog = userBlog.objects.filter(id=pk)
    context = {}
    context['blogs'] = blog
    return render(request, 'main/blogPage.html', context)


@login_required(login_url="/account/login/")
def deleteBlog(request, pk):
    instance = userBlog.objects.get(id=pk)
    instance.delete()
    return redirect('articles:blogList')


@login_required(login_url="/account/login/")
def createBlog(request):
    form = forms.createBlogForm()
    if request.method == 'POST':
        form = forms.createBlogForm(request.POST, request.FILES)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.createBlogForm()
    return render(request, 'main/createBlogs.html', {'form': form})


@login_required(login_url="/account/login/")
def editBlogs(request, pk):
    blogs = userBlog.objects.get(id=pk)
    blogDate = blogs.date
    blogTitle = blogs.Title
    blogtext = blogs.text
    blogimage = blogs.place_Img1
    form = forms.createBlogForm()
    if request.method == 'POST':
        form = forms.createBlogForm(request.POST, request.FILES)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.id = pk
            instance.user = request.user
            if form.cleaned_data['Title'] is None or form.cleaned_data['Title'] == '':
                instance.Title = blogTitle
            if form.cleaned_data['text'] is None or form.cleaned_data['text'] == '':
                instance.text = blogtext
            if form.cleaned_data['place_Img1'] is None:
                instance.place_Img1 = blogimage

            instance.date = blogDate
            instance.save()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.createBlogForm()
    return render(request, 'main/editBlogs.html', {'form': form})


@login_required(login_url="/account/login/")
def usersearch(request):
    return render(request, 'main/usersearch.html')


@login_required(login_url="/account/login/")
def searcheduser(request):
    if request.method == 'POST':
        search = request.POST['user-search']
        context = {}
        context['usersearch'] = search
        userprofile = userProfile.objects.filter(user_name__icontains=search)
        context['userprofile'] = userprofile
    return render(request, 'main/searcheduser.html', context)


@login_required(login_url="/account/login/")
def searchedUserProfile(request, pk):
    if pk is None:
        profile = userProfile.objects.filter(id=1)
    else:
        profile = userProfile.objects.filter(id=pk)
    context = {}
    context['profile'] = profile
    return render(request, 'main/searchedUserProfile.html', context)


@login_required(login_url="/account/login/")
def appRating(request):
    starRating = request.POST.get('star_rating')
    form = forms.appReviewForm()
    if request.method == 'POST':
        form = forms.appReviewForm(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.user = request.user
            instance.rate = int(starRating)
            instance.save()

            return HttpResponseRedirect(request.path_info)
    else:
        form = forms.appReviewForm()
    return render(request, 'main/appRating.html', {'form': form})


@login_required(login_url="/account/login/")
def showAppRating(request):
    AppReview = appReview.objects.all()
    profile = userProfile.objects.filter(user=request.user)
    context = {}
    context['appReview'] = AppReview
    context['profile'] = profile
    return render(request, 'main/showAppRating.html', context)


def deleteAppRating(request, pk):
    instance = appReview.objects.get(id=pk)
    instance.delete()
    return redirect('articles:showAppRating')
