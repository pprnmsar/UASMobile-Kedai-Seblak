import 'package:flutter/material.dart';
import 'package:seblak2/constans.dart';
import 'package:seblak2/users/akunpage.dart';
import 'package:seblak2/users/depanpage.dart';
import 'package:seblak2/users/kategoripage.dart';
import 'package:seblak2/users/keranjangpage.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int bottomNavCurrentIndex = 0;
  List<Widget> container = [
    new DepanPage(),
    new KategoriPage(),
    new KeranjangPage(),
    new AkunPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: container[bottomNavCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Palette.bg1,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            bottomNavCurrentIndex = index;
          });
        },
        currentIndex: bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.home,
              color: Palette.bg1,
            ),
            icon: new Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.category_outlined,
              color: Palette.bg1,
            ),
            icon: new Icon(
              Icons.category_outlined,
              color: Colors.grey,
            ),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.shopping_cart,
              color: Palette.bg1,
            ),
            icon: new Icon(
              Icons.shopping_cart_outlined,
              color: Colors.grey,
            ),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.person,
              color: Palette.bg1,
            ),
            icon: new Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
