import 'package:flutter/material.dart';
import 'package:product_list_app/product.dart';

class ProductCard extends StatelessWidget {
  final Urun urun;
  const ProductCard({super.key, required this.urun});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(child: Image.asset(urun.resim, fit: BoxFit.fill)),
          Text(urun.ad),
          Text("${urun.fiyat} TL", style: TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Ürün Eklendi"),
                    content: Text("${urun.ad} sepete eklendi"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Tamam"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text("SEPETE EKLE"),
          ),
        ],
      ),
    );
  }
}
