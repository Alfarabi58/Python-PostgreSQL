'''
=================================================

Nama  : Alfarabi

Program ini dibuat untuk melakukan automatisasi pengolahan (cleaning) data text yang berguna untuk pemodelan model analisa sentimen.
=================================================
'''

class cart_item:

    def __init__ (self, nama = str, harga = int):
        self.nama = nama
        self.harga = harga

class shopping_cart:
    def __init__ (self):
        self.keranjang = []

    def tambah_barang(self, barang):
        self.keranjang.append(barang)

    def hapus_barang(self, barang_hapus):
       self.keranjang = [item for item in self.keranjang if item.nama != barang_hapus]

    def tampikan_barang(self):
        if len(self.keranjang) < 1:
            print()
            print('Barang Tidak Terserdia')
        else:
            for i in range (len(self.keranjang)):
                print()
                print(f'{i + 1} {self.keranjang [i].nama} Rp.{self.keranjang[i].harga}')

    def total_belanja(self):
        total = sum(item.harga for item in self.keranjang)
        print(f"Harga total: {total}")
        return total
        
def input_data ():
    item_keranjang = shopping_cart()
    while True:
        print('''
Selamat Datang di Keranjang Belanja Toko Makmur !
              
Menu:
1. Menambah Barang
2. Hapus Barang
3. Tampilkan Barang di Keranjang
4. Lihat Total Belanja
5. Exit
''')
        menu = input('Input menu or exit: ')

        if menu == '1':
            nama_barang = input('Nama Barang: ')
            harga_barang = int(input('Harga Barang: '))
            ambil_barang = cart_item(nama_barang, int(harga_barang))
            item_keranjang.tambah_barang(ambil_barang)

        elif menu == '2':
            if len(item_keranjang.keranjang) == 0:
                print('Keranjang Kosong, Silahkan Pilih Menu 1 Untuk Menambah Barang')
            else: 
                nama_barang_hapus = input('Nama barang yang akan dihapus: ')
                for i in item_keranjang.keranjang:
                    if nama_barang_hapus == i.nama:
                        item_keranjang.hapus_barang(nama_barang_hapus)
                        print(f'Barang {nama_barang_hapus} sudah dihapus')

        elif menu == '3':
            item_keranjang.tampikan_barang()
        
        elif menu == '4':
            item_keranjang.total_belanja()

        elif menu.lower() == '5':
            print('Sampai Jumpa! Terima kasih sudah belanja di Toko Makmur.')
            break

        else:
            print('COBA LAGI!!!')

if __name__ == '__main__':
    input_data()