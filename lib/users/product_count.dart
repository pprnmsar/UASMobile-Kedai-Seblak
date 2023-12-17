import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seblak2/users/landing.dart';

class ProductCount extends StatefulWidget {
  final dynamic menu;
  ProductCount({required this.menu, super.key});

  @override
  _ProductCountState createState() => _ProductCountState();
}

class _ProductCountState extends State<ProductCount> {
  int productCount = 1;

  void incrementCount() {
    setState(() {
      productCount++;
    });
  }

  void decrementCount() {
    setState(() {
      if (productCount > 1) {
        productCount--;
      }
    });
  }

  Future<dynamic> tambahKeranjang() async {
    String uuid = '';
    final dio = Dio();

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      uuid = user.uid;
    }

    try {
      final response = await dio.post(
        'https://seblak-6cf5a-default-rtdb.firebaseio.com/keranjang.json',
        data: {
          'uuid': uuid,
          'dekripsi': widget.menu['deskripsi'],
          'image': widget.menu['image'],
          'kategori': widget.menu['kategori'],
          'nama': widget.menu['nama'],
          'price': widget.menu['price'],
          'jumlah': productCount
        },
      );

      if (response.statusCode == 200) {
        print('Keranjang berhasil ditambahkan');
      } else {
        print('Gagal menambahkan cart: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengirim permintaan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            FloatingActionButton.small(
              heroTag: null,
              backgroundColor: Color(0xffD9D9D9),
              onPressed: decrementCount,
              child: const Icon(Icons.remove, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                productCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            FloatingActionButton.small(
              onPressed: incrementCount,
              backgroundColor: Color(0xffD9D9D9),
              heroTag: null,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              tambahKeranjang();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Produk Ditambahkan"),
                    content:
                        Text("Produk telah berhasil ditambahkan ke keranjang."),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandingPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(158, 0, 0, 1),
            ),
            child: Text(
              "Add to Cart",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
