import 'package:flutter/material.dart';
import 'package:seblak2/users/detail_screen.dart';

class SeblakCard extends StatelessWidget {
  final dynamic menu;

  SeblakCard({required this.menu});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeblakDetailPage(menu: menu),
          ),
        );
      },
      child: Container(
        width: 190,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(0, 238, 238, 238).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                menu['image'],
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu['nama'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Colors.amber,
                      ),
                      Text(
                        'Rp ${menu['price']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
