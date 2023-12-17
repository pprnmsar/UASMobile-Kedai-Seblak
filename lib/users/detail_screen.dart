import 'package:flutter/material.dart';
import 'package:seblak2/users/product_count.dart';

class SeblakDetailPage extends StatefulWidget {
  final dynamic menu;

  SeblakDetailPage({required this.menu});

  @override
  _SeblakDetailPageState createState() => _SeblakDetailPageState();
}

class _SeblakDetailPageState extends State<SeblakDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double imageHeight = size.height * 0.6;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: imageHeight,
              width: size.width,
              child: Image.network(
                widget.menu['image'],
                fit: BoxFit.cover,
              ),
            ),

            Container(
              width: size.width,
              height: size.height * 0.50,
              margin: EdgeInsets.only(top: size.height * 0.50, bottom: 70),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                children: [
                  Text(
                    widget.menu['nama'],
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rp ${widget.menu['price']}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 69, 158, 34),
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.menu['deskripsi'],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(0xff555050),
                          height: 1.5,
                        ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.bottomCenter,
              child: ProductCount(menu: widget.menu),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
