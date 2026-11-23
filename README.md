# myportofolio_mobile

# Tugas 7

>Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

1. Widget tree adalah hierarki widget yang building flutter screennya. Setiap widget merepresentasikan component-component UI nya, seperti text, button, spacing, atau layout. Lalu hubungan antar parent-child itu berarti parent mengontrol bagaimana cara menyusun child

<br>

>Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

2. MyHomePage fungsinya menyusun halaman utama, InfoCard menampilkan satu informasi indentitas, ItemCard menampilkan satu menu yang bisa ditekan

<br>

>Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

3. Widget MaterialApp menyediakan pola tampilan awal dan kerap dijadikan sebagai root agar semua halaman dapat memiliki tampilan atau konfigurasi yang konsisten

<br>

>Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

4. stateless widget sesuai namanya itu static atau tidak berubah setelah dibuat. Widget ini tidak menyimpan state internal atau data apapun. Oleh karena itu, widget ini cocok digunakan ketika elemen tampilan tidak membutuhkan interaksi dengan pengguna. Sedangkan, Stateful widget adalah kebalikannnya. Widget ini sifatnya dinamis atau bisa berubah-ubah seiring waktu. Widget ini bisa menyimpan state internal dan cocok digunakan ketika element tampilan memiliki interaksi dengan pengguna, contohnya seperti ketika pengguna perlu menekan tombol untuk men-submit form.

<br>

>Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

5. BuildContext adalah object yang dibuat flutter ketika suatu method build() dipanggil. Object ini menunjukkan posisi widget di widget tree, sehingga method build() bisa mengakses informasi atau fasilitas tentang widget terkait. 

<br>

>Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

6. Hot reload adalah ketika kita ingin memperbarui code dart dan menjalankan ulang proses build() tanpa mereset state yang ada. bedanya dengan hot restart adalah menjalan ulang aplikasi dart dari main(), sehingga state di memory di reset, tetapi aplikasi tetap berjalan. Pada full restart,  proses menghentikan aplikasi, kemudian melakukan rebuild dan meluncurkan ulang aplikasi.

# Tugas 8

>Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

1. `Navigator.push()` menambahkan halaman baru ke atas tumpukan dan halaman sebelumnya tetap ada. `Navigator.pushReplacement()` mengganti halaman yang sedang aktif dengan halaman baru. `Navigator.pop()` menutup halaman atau dialog di posisi teratas. Kartu **Tambah Pengalaman** memakai `Navigator.push()` untuk membuka `ExperienceForm`, jadi tombol Back bisa kembali ke halaman utama. Opsi **Home** di `LeftDrawer` memakai `Navigator.pushReplacement()` untuk mengganti halaman aktif dengan `MyHomePage`.

<br>

>Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

2. `Scaffold` menyediakan tempat untuk `AppBar` di atas, `Drawer` di samping, dan konten utama di `body`. Halaman utama dan halaman formulir memakai `LeftDrawer` yang sama, jadi posisi dan isi menu tetap konsisten. Contohnya, `AppBar` di halaman Tambah Pengalaman dan Tambah Achievement sama-sama menggunakan `Colors.indigo`.

<br>

>Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

3. Saya memakai `Column` supaya field tersusun dari atas ke bawah sesuai urutan pengisian. `Padding` memberi jarak di sekitar tiap field supaya kolom tidak saling menempel. `SingleChildScrollView` membuat form bisa digulir sampai tombol Simpan saat layar kecil atau keyboard sedang terbuka.

<br>

>Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

4. `GlobalKey<FormState>` memberi tombol Simpan akses ke `FormState`. Saat tombol ditekan, `validate()` menjalankan `validator` pada setiap field. Validator mengembalikan pesan error jika nilai tidak valid dan `null` jika valid. Dialog ringkasan hanya muncul kalau semua field lolos. Contohnya, kolom tautan logo di form Pengalaman menolak `contoh.com/logo.png` karena tidak diawali `http://` atau `https://`. `TextInputType.url` menyesuaikan tombol di keyboard, sementara aturan URL diperiksa oleh validator.


## AI Disclosure

Saya tidak menggunakan AI pada tugas ini