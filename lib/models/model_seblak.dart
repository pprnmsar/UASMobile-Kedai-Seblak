import 'dart:convert';

Seblak SeblakFromJson(String str) => Seblak.fromJson(json.decode(str));

String SeblakToJson(Seblak data) => json.encode(data.toJson());

class Seblak {
    String nama;
    String kategori;
    String deskripsi;
    String price;
    String image;

    Seblak({
        required this.nama,
        required this.kategori,
        required this.deskripsi,
        required this.price,
        required this.image,
    });

    factory Seblak.fromJson(Map<String, dynamic> json) => Seblak(
        nama: json["nama"],
        kategori: json["kategori"],
        deskripsi: json["deskripsi"],
        price: json["price"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "kategori": kategori,
        "deskripsi": deskripsi,
        "price": price,
        "image": image,
    };
}
