import 'dart:convert';

Cart CartFromJson(String str) => Cart.fromJson(json.decode(str));

String CartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String uuid;
  String nama;
  String kategori;
  String deskripsi;
  String price;
  String image;

  Cart({
    required this.uuid,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.price,
    required this.image,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        uuid: json["uuid"],
        nama: json["nama"],
        kategori: json["kategori"],
        deskripsi: json["deskripsi"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "nama": nama,
        "kategori": kategori,
        "deskripsi": deskripsi,
        "price": price,
        "image": image,
      };
}
