'''
=================================================

Nama  : Alfarabi

Program ini dibuat untuk melakukan automatisasi pengolahan (cleaning) data text yang berguna untuk pemodelan model analisa sentimen.
=================================================
'''

import unittest
from alfarabi__app import cart_item, shopping_cart

class TestShoppingCart(unittest.TestCase):

    def setUp(self):
        self.item_keranjang = shopping_cart()
        self.item_keranjang.keranjang = [] 

    def test_tambah_barang(self):
        self.item_keranjang.tambah_barang(cart_item('Ayam', 20000))
        self.assertEqual(len(self.item_keranjang.keranjang), 1) 

    def test_hapus_barang(self):
        barang = cart_item('Ayam', 20000)
        self.item_keranjang.tambah_barang(barang)
        self.item_keranjang.hapus_barang(barang.nama)
        self.assertEqual(len(self.item_keranjang.keranjang), 0)

    def test_total_belanja(self):
        barang1 = cart_item('Ayam', 20000)        
        barang2 = cart_item('Bebek', 25000)
        self.item_keranjang.tambah_barang(barang1)
        self.item_keranjang.tambah_barang(barang2)
        self.assertEqual(self.item_keranjang.total_belanja(), 45000)

if __name__ == '__main__':
    unittest.main()
