
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seblak2/users/detail_screen.dart';

class SearchResult extends StatefulWidget {
  final String searchKeyword;

  SearchResult({required this.searchKeyword});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  dynamic _searchResults = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<dynamic> getData() async {
    try {
      final response = await Dio().get(
        'https://seblak-6cf5a-default-rtdb.firebaseio.com/menu.json',
        queryParameters: {'nama': widget.searchKeyword},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        _searchResults = responseData.cast<Map<String, dynamic>>();
        setState(() {
          print('SEARCH RESULT : $_searchResults');
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error
    }
  }

  // Future<void> _fetchSearchResults() async {
  //   try {
  //     final response = await Dio().get(
  //       'http://192.168.18.13:8000/api/movie/getMovie',
  //       queryParameters: {'judul': widget.searchKeyword},
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = response.data['data'];

  //       setState(() {
  //         _searchResults = responseData.cast<Map<String, dynamic>>();
  //       });
  //     } else {
  //       throw Exception('Failed to load search results');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     // Handle error
  //   }
  // }

  dynamic _performSearch() {
    String trimmedQuery = widget.searchKeyword.toLowerCase().trim();

    return _searchResults
        .where((menuData) =>
            (menuData["nama"] as String).toLowerCase().contains(trimmedQuery))
        .toList()
        .cast<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = _performSearch();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search Results for: ${widget.searchKeyword}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        searchResults != null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.95,
                ),
                itemCount: searchResults.length,
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
                                SeblakDetailPage(menu: searchResults[index]),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Image.network(
                            searchResults[index]['image'],
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  searchResults[index]['nama'],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp${searchResults[index]['price']}',
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
      ],
    );
  }
}
