import 'package:flutter/material.dart';
import 'package:product_list_app/models/product.dart';
import 'package:product_list_app/screens/product_card.dart';
import 'package:product_list_app/models/cart_item.dart';
import 'package:product_list_app/widgets/cart_dialog.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CartItem> _shopBag = [];
  final List<Product> urunler = [
    Product(name: "Pants", picture: "assets/images/pantolon.webp", cost: 300),
    Product(name: "Perfume", picture: "assets/images/parfüm.webp", cost: 400),
    Product(name: "Shoes", picture: "assets/images/ayakkabi.jpg", cost: 700),
    Product(name: "Bag", picture: "assets/images/çanta.jpg", cost: 200),
    Product(name: "Phone Case", picture: "assets/images/kilif.webp", cost: 500),
    Product(name: "Shirt", picture: "assets/images/gömlek.webp", cost: 800),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setDialogState) {
                      return CartDialog(shopBag: _shopBag);
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.shopping_cart),
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
            expandedHeight: 20, //sliverappbarin ilk açildiğindaki yüksekliği
            pinned: true,
            floating: false,
            snap: false,
            actions: [
              Builder(
                builder: (context) {
                  return PopupMenuButton(
                    onSelected: (value) {
                      String message = "";
                      if (value == "name") {
                        setState(() {
                          urunler.sort((a, b) => a.name.compareTo(b.name));
                        });
                      } else if (value == "price") {
                        setState(() {
                          urunler.sort((a, b) => a.cost.compareTo(b.cost));
                        });
                      } else if (value == "default") {
                        message = "Default sorting";
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "name",
                        child: Text("Sorted by name"),
                      ),
                      PopupMenuItem(
                        value: "price",
                        child: Text("Sorted by price"),
                      ),
                      PopupMenuItem(
                        value: "default",
                        child: Text("Default sorting"),
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
                return ProductCard(
                  urun: urunler[index],
                  onAddToCart: () {
                    setState(() {
                      int cartIndex = _shopBag.indexWhere(
                        (item) => item.product.name == urunler[index].name,
                      );
                      if (cartIndex != -1) {
                        _shopBag[cartIndex].quantity++;
                      } else {
                        _shopBag.add(CartItem(product: urunler[index]));
                      }
                    });
                  },
                );
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
    );
  }
}

