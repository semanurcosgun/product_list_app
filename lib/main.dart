import 'package:flutter/material.dart';
import 'package:product_list_app/product.dart';
import 'package:product_list_app/product_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final List<Urun> urunler = [
    Urun(ad: "Pantolon", resim: "assets/images/pantolon.webp", fiyat: 300),
    Urun(ad: "Parfüm", resim: "assets/images/parfüm.webp", fiyat: 400),
    Urun(ad: "Ayakkabi", resim: "assets/images/ayakkabı.jpg", fiyat: 700),
    Urun(ad: "Çanta", resim: "assets/images/çanta.jpg", fiyat: 200),
    Urun(ad: "Kilif", resim: "assets/images/kılıf.webp", fiyat: 500),
    Urun(ad: "Gömlek", resim: "assets/images/gömlek.webp", fiyat: 800),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Sepetinizde 1 ürün var")),
                );
              },
              child: Icon(Icons.shopping_cart),
            );
          },
        ),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.pink,
              title: Text("STORE"),
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              expandedHeight: 30, //sliverappbarın ilk açıldığındaki yüksekliği
              pinned: true,
              floating: false,
              snap: false,
              actions: [
                Builder(
                  builder: (context) {
                    return PopupMenuButton(
                      onSelected: (value) {
                        String mesaj = "";
                        if (value == "ad") {
                          mesaj = "Ada göre siralandi";
                        } else if (value == "fiyat") {
                          mesaj = "Fiyata göre siralandi";
                        } else if (value == "varsayilan") {
                          mesaj = "Varsayilan siralama";
                        }
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(mesaj)));
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "ad",
                          child: Text("Ada göre siralandi"),
                        ),
                        PopupMenuItem(
                          value: "fiyat",
                          child: Text("Fiyata göre siralandi"),
                        ),
                        PopupMenuItem(
                          value: "varsayilan",
                          child: Text("Varsayilan göre sirala"),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),

            SliverPadding(
              padding: EdgeInsets.all(5),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ProductCard(urun: urunler[index]);
                }, childCount: urunler.length),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 25,
                  childAspectRatio: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
