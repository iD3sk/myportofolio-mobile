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