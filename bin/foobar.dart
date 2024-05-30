import 'dart:io';

abstract class FooBar {
  static void run() {
    // step 1: Siapkan penampung
    List<dynamic> collections = [];

    // step 2: Looping bilangan 1 sampai 100 secara decrement
    for (var i = 100; i >= 1; i--) {
      // step 3: Cek rule
      if (_isPrime(i)) {
        // case: Bilangan prima
        // Jangan dimasukkan ke dalam penampung
        null;
      } else if (i % 3 == 0 && i % 5 == 0) {
        // case: Bilangan habis dibagi 3 dan 5
        // Ganti dengan teks `FooBar`
        collections.add('FooBar');
      } else if (i % 3 == 0) {
        // case: Bilangan habis dibagi 3
        // Ganti dengan teks `Foo`
        collections.add('Foo');
      } else if (i % 5 == 0) {
        // case: Bilangan habis dibagi 5
        // Ganti dengan teks `Bar`
        collections.add('Bar');
      } else {
        // case: Selain ketentuan di atas
        // Masukkan bilangan ke dalam penampung
        collections.add(i);
      }
    }

    // step 4: Print value penampung
    collections.map((e) => stdout.write('$e, ')).toString();
  }

  /// Fungsi untuk menentukan suatu bilangan merupakan bilangan prima atau tidak
  static bool _isPrime(int number) {
    // Bilangan kurang dari atau sama dengan 1 bukan bilangan prima
    if (number <= 1) return false;

    // Bilangan 2 dan 3 adalah bilangan prima
    if (number <= 3) return true;

    // Kelipatan 2 dan 3 bukan bilangan prima
    if (number % 2 == 0 || number % 3 == 0) return false;

    // Periksa faktor-faktor dari 5 hingga akar kuadrat dari 'number'
    for (var i = 5; i * i < number; i += 6) {
      // Jika habis dibagi i atau i+2, bukan bilangan prima
      if (number % i == 0 || number % (i + 2) == 0) return false;
    }

    // Jika tidak ada faktor yang ditemukan, maka termasuk bilangan prima
    return true;
  }
}
