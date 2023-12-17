import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seblak2/component/home_card.dart';
import 'package:seblak2/constans.dart';
import 'package:seblak2/users/SearchResults.dart';

class DepanPage extends StatefulWidget {
  @override
  State<DepanPage> createState() => _DepanPageState();
}

class _DepanPageState extends State<DepanPage> {
  var menuSeblak = [];
  var menuBakso = [];
  String _searchQuery = '';

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
        automaticallyImplyLeading: false,
        title: TextField(
          onTap: () {},
          style: TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Palette.orange),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: new BorderSide(color: Colors.white),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
          ),
          onChanged: (value) {
            // Update nilai pencarian saat bidang pencarian berubah
            setState(() {
              _searchQuery = value;
              // _fetchSearchResults();
            });
          },
        ),
        backgroundColor: Palette.bg1,
      ),
      body: menuSeblak.isNotEmpty
          ? SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  if (_searchQuery.isNotEmpty)
                    SearchResult(searchKeyword: _searchQuery)
                  else
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Menu Seblak",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 280, // Set the height of the ListView
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: menuSeblak.length,
                            itemBuilder: (context, index) {
                              return SeblakCard(menu: menuSeblak[index]);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Menu Bakso",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 280, // Set the height of the ListView
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: menuBakso.length,
                            itemBuilder: (context, index) {
                              return SeblakCard(menu: menuBakso[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                ]),
              ),
            )
          : Container(
              // Tampilkan widget loading atau pesan "Data belum diambil"
              alignment: Alignment.center,
              child: CircularProgressIndicator(), // Atau widget lainnya
            ),
    );
  }
}
