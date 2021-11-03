from django.forms.widgets import Input
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, redirect
from django.template import loader

from .models import Article
from django.contrib.auth.decorators import login_required

from django.http import FileResponse
import io
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib.pagesizes import letter
from django.core.mail import send_mail

from .models import balaka

from . import forms


# Create your views here.
@login_required(login_url="/accounts/login/")
def homepage(request):
    return render(request, 'main/homepage.html')


@login_required(login_url="/accounts/login/")
def bus_details(request, slug):
    # return HttpResponse(slug)
    return render(request, 'main/bus_details.html')


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

        #send email
        send_mail(
            'Mail Sent By '+message_name , # subject
            '\n'+'Senders Phone: '+message_phone + '\nSenders Email: '+message_email+ ' \nMessage: ' + message, #message
            message_email, #from mail
            ['2018-3-60-088@std.ewubd.edu'], #tomail
        )
        return render(request, 'main/contact.html', {'message_name': message_name})
    else:
        return render(request, 'main/contact.html')


@login_required(login_url="/account/login/")
def ticket_page(request):
    return render(request, 'main/ticket_page.html')


@login_required(login_url="/account/login/")
def ticket_page(request):
    ticket_page.message_name = request.POST.get('message-name')
    ticket_page.message_email = request.POST.get('message-email')
    ticket_page.message_phone = request.POST.get('message-phone')
    ticket_page.message_start = request.POST.get('message-start')
    ticket_page.message_end = request.POST.get('message-end')
    ticket_page.message_date = request.POST.get('message-date')
    ticket_page.message_bus = request.POST.get('message-bus')
    ticket_page.text = request.POST.get('message-text')

    return render(request, 'main/ticket_page.html', {'message_name': ticket_page.message_name})


@login_required(login_url="/account/login/")
def ticket(request):
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=letter, bottomup=0)
    textob = c.beginText()
    textob.setTextOrigin(inch, inch)
    textob.setFont("Helvetica", 14)
    name = ticket_page.message_name
    mail = ticket_page.message_email
    phone = ticket_page.message_phone
    start = ticket_page.message_start
    end = ticket_page.message_end
    date = ticket_page.message_date
    bus = ticket_page.message_bus
    text = ticket_page.text
    # print(text)

    lines = [
        "Welcome to optimal transportation system",
        " ",
        "Your ticket is below",
        " ",
        "Full name: " + name,
        " ",
        "Email: " + mail,
        " ",
        "Phone: "+phone,
        " ",
        "Pickup place: "+start,
        " ",
        "Destination: "+end,
        " ",
        "Journey Date: "+date,
        " ",
        "Bus: "+bus,
        " ",
        ""+text,
        "",
        "All right reserved by optimal transportation system",

    ]

    for line in lines:
        textob.textLine(line)

    c.drawText(textob)
    c.showPage()
    c.save()
    buf.seek(0)

    return FileResponse(buf, as_attachment=True, filename="ticket.pdf")


# Air
@login_required(login_url="/account/login/")
def Air_Biman_Bangladesh(request):
    return render(request, 'main/Air_Biman_Bangladesh.html')


@login_required(login_url="/account/login/")
def Air_Novoair(request):
    return render(request, 'main/Air_Novoair.html')


@login_required(login_url="/account/login/")
def Air_US_Bangla(request):
    return render(request, 'main/Air_US_Bangla.html')


# Bus
@login_required(login_url="/account/login/")
def bolaka(request):

    Balaka = balaka.objects.all().order_by('date')
    return render(request, 'main/bolaka.html', {'Balaka': Balaka})


@login_required(login_url="/account/login/")
def bolakareview(request):
    form = forms.balakareview()
    if request.method == 'POST':
        form = forms.balakareview(request.POST)
        if form.is_valid():
            # save to db
            instance = form.save(commit=False)
            instance.user = request.user
            instance.save()
            # instance = balaka.objects.get(id=id)
            # instance.delete()
            next = request.POST.get('next', '/')
            return HttpResponseRedirect(next)
    else:
        form = forms.balakareview()
    return render(request, 'main/balakareview.html', {'form': form})


def deletebalaka(request, pk):
    instance = balaka.objects.get(id=pk)
    instance.delete()
    return redirect('articles:bolaka')


@login_required(login_url="/account/login/")
def Bus_Akash(request):
    Balaka = balaka.objects.all().order_by('date')
    return render(request, 'main/Bus_Akash.html', {'Balaka': Balaka})


@login_required(login_url="/account/login/")
def Bus_Alif(request):
    Balaka = balaka.objects.all().order_by('date')
    return render(request, 'main/Bus_Alif.html', {'Balaka': Balaka})


@login_required(login_url="/account/login/")
def Bus_Anabil(request):
    return render(request, 'main/Bus_Anabil.html')


@login_required(login_url="/account/login/")
def Bus_BRTC(request):
    Balaka = balaka.objects.all().order_by('date')
    return render(request, 'main/Bus_BRTC.html', {'Balaka': Balaka})


@login_required(login_url="/account/login/")
def Bus_Green_Dhaka(request):
    return render(request, 'main/Bus_Green_Dhaka.html')


@login_required(login_url="/account/login/")
def Bus_Raida(request):
    Balaka = balaka.objects.all().order_by('date')
    return render(request, 'main/Bus_Raida.html', {'Balaka': Balaka})



@login_required(login_url="/account/login/")
def Bus_Skyline(request):
    return render(request, 'main/Bus_Skyline.html')


@login_required(login_url="/account/login/")
def Bus_Supravat(request):
    return render(request, 'main/Bus_Supravat.html')


@login_required(login_url="/account/login/")
def Bus_VIP(request):
    Balaka = balaka.objects.all().order_by('date')
    return render(request, 'main/Bus_VIP.html', {'Balaka': Balaka})



# Train
@login_required(login_url="/account/login/")
def Train_Chitra_Express(request):
    return render(request, 'main/Train_Chitra_Express.html')


@login_required(login_url="/account/login/")
def Train_Ekota_Express(request):
    return render(request, 'main/Train_Ekota_Express.html')


@login_required(login_url="/account/login/")
def Train_Mahanagar_Godhuli(request):
    return render(request, 'main/Train_Mahanagar_Godhuli.html')


@login_required(login_url="/account/login/")
def Train_Suborno_Express(request):
    return render(request, 'main/Train_Suborno_Express.html')


@login_required(login_url="/account/login/")
def Train_Tista_Express(request):
    return render(request, 'main/Train_Tista_Express.html')


@login_required(login_url="/account/login/")
def offers(request):
    articles = Article.objects.all()
    return render(request, 'main/offers.html', {'articles': articles})


