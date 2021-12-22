from django.test import SimpleTestCase
from django.urls import reverse, resolve
from .views import homepage, about, contact, hotelReview, deleteHotelReview, resturantReview, deleteresturantReview, placeReview, \
    deleteplaceReview, hotel_booking, hotel_bookingPdf, RoomShow, hotel_page, placelist, place, resturantList, resturantShow


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


class ViewTest(SimpleTestCase):
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





