import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seblak2/constans.dart';
import 'package:http/http.dart' as http;
import 'package:seblak2/users/detail_screen.dart';

class KategoriPage extends StatefulWidget {
  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  var menuSeblak = [];
  var menuBakso = [];
  var menuCemilan = [];
  var menuMinuman = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://seblak-6cf5a-default-rtdb.firebaseio.com/menu.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      data.forEach((key, value) {
        if (value['kategori'] == 'Seblak') {
          menuSeblak.add(value);
        }
        if (value['kategori'] == 'Bakso Aci') {
          menuBakso.add(value);
        }
        if (value['kategori'] == 'Cemilan') {
          menuCemilan.add(value);
        }
        if (value['kategori'] == 'Minuman') {
          menuMinuman.add(value);
        }
      });

      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori', style: TextStyle(color: Palette.orange)),
        backgroundColor: Palette.bg1,
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Jumlah kolom dalam grid
        children: <Widget>[
          _buildCategoryCard('Seblak', 'Seblak Pedas', 5.99,
              'assets/food_4.jpeg', SubMenuPage("Seblak Menu", menuSeblak)),
          _buildCategoryCard('Baso Aci', 'Baso Aci Spesial', 6.99,
              'assets/food_2.jpeg', SubMenuPage("Bakso Aci Menu", menuBakso)),
          _buildCategoryCard('Cemilan', 'Keripik Kentang', 3.99,
              'assets/cemilan.jpg', SubMenuPage("Cemilan Menu", menuCemilan)),
          _buildCategoryCard('Minuman', 'Es Teh Manis', 2.49,
              'assets/minuman.jpg', SubMenuPage("Minuman Menu", menuMinuman)),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String categoryName, String description,
      double price, String imagePath, Widget nextPage) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 10.0,
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman submenu saat kategori dipilih
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => nextPage));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubMenuPage extends StatelessWidget {
  final String menuName;
  final dynamic menu;

  SubMenuPage(this.menuName, this.menu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menuName),
      ),
      body: menu.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.95,
              ),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 10.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SeblakDetailPage(menu: menu[index]),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Image.network(
                          menu[index]['image'],
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                menu[index]['nama'],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp${menu[index]['price']}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Container(
              // Tampilkan widget loading atau pesan "Data belum diambil"
              alignment: Alignment.center,
              child: CircularProgressIndicator(), // Atau widget lainnya
            ),
    );
  }
}
