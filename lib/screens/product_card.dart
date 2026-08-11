import 'package:flutter/material.dart';
import 'package:product_list_app/models/product.dart';
import 'package:product_list_app/screens/home_screen.dart';

//TODO 
//Ürünleri sepete ekleyeceğiz. Sepet butonuna tıklandığında sepet açılsın. ListTile ile listele. + sepet miktarı adet*fiyat gösterdim +
//Ürünler silinebilsin. Ekleme veya silme yaptığımda sepet güncellensin.+
//Registerdaki textfield custom text field ile değişsin.+
//Product modelinde türkçe isim kalmasın. +
//username i shared preferences ile tutalım. +
//semanurcsgn kabul etsin direkt+

class ProductCard extends StatefulWidget {
  final Product urun;
  final VoidCallback onAddToCart;
 
  ProductCard({super.key, required this.urun,required this.onAddToCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
  
}
class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) { 
    return Card(
      child: Column(
        children: [
          Expanded(child: Image.asset(widget.urun.picture, fit: BoxFit.fill)),
          Text(widget.urun.name),
          Text("${widget.urun.cost} TL", style: TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () {
             widget.onAddToCart();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Product Added"),
                    content: Text("${widget.urun.name} added to cart"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}