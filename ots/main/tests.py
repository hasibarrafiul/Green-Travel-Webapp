from django.test import SimpleTestCase, TestCase
from django.urls import reverse, resolve
from .forms import HotelReview, ResturantReview, PlaceReview

from .models import RoomModel, Place, ResturantInfo
from .views import homepage, about, contact, hotelReview, deleteHotelReview, resturantReview, deleteresturantReview, \
    placeReview, \
    deleteplaceReview, hotel_booking, hotel_bookingPdf, RoomShow, hotel_page, placelist, place, resturantList, \
    resturantShow

from django.core.files.uploadedfile import SimpleUploadedFile


class UrlsTest(SimpleTestCase):
    def test_homepage(self):
        url = reverse('articles:list')
        self.assertEquals(resolve(url).func, homepage)

    def test_about(self):
        url = reverse('articles:about')
        self.assertEquals(resolve(url).func, about)

    def test_contact(self):
        url = reverse('articles:contact')
        self.assertEquals(resolve(url).func, contact)

    def test_hotelReview(self):
        url = reverse('articles:hotelReview')
        self.assertEquals(resolve(url).func, hotelReview)

    def test_deleteHotelReview(self):
        url = reverse('articles:deleteHotelReview', args=['slug'])
        self.assertEquals(resolve(url).func, deleteHotelReview)

    def test_resturantReview(self):
        url = reverse('articles:resturantReview')
        self.assertEquals(resolve(url).func, resturantReview)

    def test_deleteresturantReview(self):
        url = reverse('articles:deleteResturantReview', args=['slug'])
        self.assertEquals(resolve(url).func, deleteresturantReview)

    def test_placeReview(self):
        url = reverse('articles:placeReview')
        self.assertEquals(resolve(url).func, placeReview)

    def test_deleteplaceReview(self):
        url = reverse('articles:deleteplaceReview', args=['slug'])
        self.assertEquals(resolve(url).func, deleteplaceReview)

    def test_hotel_booking(self):
        url = reverse('articles:hotel_booking')
        self.assertEquals(resolve(url).func, hotel_booking)

    def test_hotel_bookingPdf(self):
        url = reverse('articles:hotel_bookingPdf')
        self.assertEquals(resolve(url).func, hotel_bookingPdf)

    def test_RoomShow(self):
        url = reverse('articles:hotel_page')
        self.assertEquals(resolve(url).func, hotel_page)

    def test_hotel_page(self):
        url = reverse('articles:RoomShow')
        self.assertEquals(resolve(url).func, RoomShow)

    def test_placelist(self):
        url = reverse('articles:placelist')
        self.assertEquals(resolve(url).func, placelist)

    def test_place(self):
        url = reverse('articles:place')
        self.assertEquals(resolve(url).func, place)

    def test_resturantList(self):
        url = reverse('articles:resturantList')
        self.assertEquals(resolve(url).func, resturantList)

    def test_resturantShow(self):
        url = reverse('articles:resturantShow')
        self.assertEquals(resolve(url).func, resturantShow)


class ViewTest(TestCase):
    def test_homepage(self):
        response = self.client.get(reverse('articles:list'))
        self.assertEquals(response.status_code, 302)

    def test_about(self):
        response = self.client.get(reverse('articles:about'))
        self.assertEquals(response.status_code, 302)

    def test_homepage(self):
        response = self.client.post(reverse('articles:contact'))
        self.assertEquals(response.status_code, 302)

    def test_hotelReview(self):
        response = self.client.post(reverse('articles:hotelReview'))
        self.assertEquals(response.status_code, 302)

    def test_deleteHotelReview(self):
        response = self.client.post(reverse('articles:deleteHotelReview', args=['slug']))
        self.assertEquals(response.status_code, 302)

    def test_resturantReview(self):
        response = self.client.post(reverse('articles:resturantReview'))
        self.assertEquals(response.status_code, 302)

    def test_deleteresturantReview(self):
        response = self.client.post(reverse('articles:deleteResturantReview', args=['slug']))
        self.assertEquals(response.status_code, 302)

    def test_placeReview(self):
        response = self.client.post(reverse('articles:placeReview'))
        self.assertEquals(response.status_code, 302)

    def test_deleteplaceReview(self):
        response = self.client.post(reverse('articles:deleteplaceReview', args=['slug']))
        self.assertEquals(response.status_code, 302)

    def test_hotel_booking(self):
        response = self.client.post(reverse('articles:hotel_booking'))
        self.assertEquals(response.status_code, 302)

    def test_hotel_bookingPdf(self):
        response = self.client.post(reverse('articles:hotel_bookingPdf'))
        self.assertEquals(response.status_code, 302)

    def test_RoomShow(self):
        response = self.client.post(reverse('articles:RoomShow'))
        self.assertEquals(response.status_code, 302)

    def test_hotel_page(self):
        response = self.client.post(reverse('articles:hotel_page'))
        self.assertEquals(response.status_code, 302)

    def test_placelist(self):
        response = self.client.post(reverse('articles:placelist'))
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'main/placelist.html')

    def test_place(self):
        response = self.client.post(reverse('articles:place'))
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'main/place.html')

    def test_resturantList(self):
        response = self.client.post(reverse('articles:resturantList'))
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'main/ResturantList.html')

    def test_resturantShow(self):
        response = self.client.post(reverse('articles:resturantShow'))
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'main/ResturantShow.html')


class TestModels(TestCase):

    def test_RoomModel(self):
        self.roomModel = RoomModel.objects.create(
            roomtype='test room',
            beds='test bed',
            baths='test bath',
            slug='test_slug',
            guests=10,
            amenities='test amenities',
            facilities='test facilities'
        )
        self.assertEquals(self.roomModel.roomtype, 'test room')
        self.assertEquals(self.roomModel.beds, 'test bed')
        self.assertEquals(self.roomModel.baths, 'test bath')
        self.assertEquals(self.roomModel.slug, 'test_slug')
        self.assertEquals(self.roomModel.guests, 10)
        self.assertEquals(self.roomModel.amenities, 'test amenities')
        self.assertEquals(self.roomModel.facilities, 'test facilities')

    def test_Place(self):
        self.place = Place.objects.create(
            name='test place',
            slug='test_slug',
            description='test description',
            route='test route',
            map_link='test map-link'
        )
        self.assertEquals(self.place.name, 'test place')
        self.assertEquals(self.place.slug, 'test_slug')
        self.assertEquals(self.place.description, 'test description')
        self.assertEquals(self.place.route, 'test route')
        self.assertEquals(self.place.map_link, 'test map-link')

    def test_ResturantInfo(self):
        self.resturantInfo = ResturantInfo.objects.create(
            name='test resturant',
            slug='test_slug',
            address='test address',
            description='test description',
            menu='test menu',
            website='test website'
        )
        self.assertEquals(self.resturantInfo.name, 'test resturant')
        self.assertEquals(self.resturantInfo.slug, 'test_slug')
        self.assertEquals(self.resturantInfo.address, 'test address')
        self.assertEquals(self.resturantInfo.description, 'test description')
        self.assertEquals(self.resturantInfo.menu, 'test menu')
        self.assertEquals(self.resturantInfo.website, 'test website')


class TestForms(SimpleTestCase):
    def test_HotelReview_Form_Valid_Data(self):
        form = HotelReview(data={
            'name': 'test name',
            'hotelName': 'Radisson_Blu',
            'review': 'test review',
            'rating': 10
        })

        self.assertTrue(form.is_valid())

    def test_HotelReview_Form_no_data(self):
        form = HotelReview(data={})
        self.assertFalse(form.is_valid())
        self.assertEquals(len(form.errors), 3)

    def test_ResturantReview_Form_Valid_Data(self):
        form = ResturantReview(data={
            'name': 'test name',
            'resturantName': 'The_Dining_Lounge',
            'review': 'test review',
            'rating': 10
        })

        self.assertTrue(form.is_valid())

    def test_ResturantReview_Form_no_data(self):
        form = HotelReview(data={})
        self.assertFalse(form.is_valid())
        self.assertEquals(len(form.errors), 3)

    def test_PlaceReview_Form_Valid_Data(self):
        form = PlaceReview(data={
            'name': 'test name',
            'placeName': 'Dhaka',
            'review': 'test review',
            'rating': 10
        })

        self.assertTrue(form.is_valid())

    def test_PlaceReview_Form_no_data(self):
        form = PlaceReview(data={})
        self.assertFalse(form.is_valid())
        self.assertEquals(len(form.errors), 3)