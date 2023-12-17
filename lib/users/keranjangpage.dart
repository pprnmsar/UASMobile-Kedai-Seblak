import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seblak2/constans.dart';
import 'package:http/http.dart' as http;

class KeranjangPage extends StatefulWidget {
  static const String routeName = '/cart-page';
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  var keranjang = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String uuid = '';

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      uuid = user.uid;
    }

    final response = await http.get(
      Uri.parse(
          'https://seblak-6cf5a-default-rtdb.firebaseio.com/keranjang.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      var updatedKeranjang = [];

      data.forEach((key, value) {
        var uuidDB = value['uuid'];
        if (uuidDB != null && uuidDB == uuid) {
          value['key'] = key;
          updatedKeranjang.add(value);
        }
      });
      setState(() {
        keranjang = updatedKeranjang;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> hapusKeranjang(String keyKeranjang) async {
    final dio = Dio();

    try {
      final response = await dio.delete(
        'https://seblak-6cf5a-default-rtdb.firebaseio.com/keranjang/$keyKeranjang.json',
      );

      if (response.statusCode == 200) {
        setState(() {
          keranjang.removeWhere((item) => item['key'] == keyKeranjang);
        });
        print('Cart item berhasil dihapus');
      } else {
        print('Gagal menghapus cart item: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengirim permintaan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang', style: TextStyle(color: Palette.orange)),
        backgroundColor: Palette.bg1,
        automaticallyImplyLeading: false,
      ),
      body: keranjang.isNotEmpty
          ? ListView.builder(
              itemCount: keranjang.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(keranjang[index]['key']),
                  onDismissed: (direction) =>
                      hapusKeranjang(keranjang[index]['key']),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 2.7,
                          child: Image.network(
                            keranjang[index]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                keranjang[index]['nama'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                keranjang[index]['kategori'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 105, 105, 105)),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Color(0xBF499E70),
                                  border: Border.all(
                                    color: Color(0xBF499E70),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Jumlah pesanan : ${keranjang[index]['jumlah']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(
                                    color: Colors.amber,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Total : Rp${keranjang[index]['jumlah'] * int.parse(keranjang[index]['price'])}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: const Text(
                'Keranjang Kosong',
              ),
            ),
    );
  }
}
