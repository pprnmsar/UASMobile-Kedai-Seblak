import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seblak2/constans.dart';
import 'package:seblak2/login.dart';
import 'package:seblak2/users/landing.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userProfile;
  String username = '', notlpn = '', uuid = '', email = '';

  void initState() {
    super.initState();
    getData();
  }

  Future <void> getData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        uuid = user.uid;
        email = user.email ?? '';
      });
    }

    try {
      var response = await Dio()
          .get('https://seblak-6cf5a-default-rtdb.firebaseio.com/users.json');
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = response.data;

        // Perulangan melalui kunci utama
        String? userProfileKey;
        for (var key in userData.keys) {
          if (userData[key]['uid'] == uuid) {
            userProfileKey = key;
            break; // Keluar dari perulangan jika UID sesuai ditemukan
          }
        }

        if (userProfileKey != null) {
          userProfile = userData[userProfileKey];
          // Sekarang, Anda memiliki data profil pengguna yang sesuai dengan UID yang login.
          setState(() {
            username = userProfile['username'];
            notlpn = userProfile['no_tlpn'];
          });
          // print(_firstNameController.text);
        } else {
          print('Profil pengguna dengan UID $uuid tidak ditemukan.');
        }
      }
      // print(jsonList);
    } catch (e) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the home screen when the back button is pressed
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingPage()),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'My Profile',
            style: TextStyle(color: Palette.orange),
          ),
          backgroundColor: Palette.bg1,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              color: Palette.orange,
              onPressed: () {
                _auth.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/putri.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(email),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(notlpn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
