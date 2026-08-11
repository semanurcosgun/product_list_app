import 'package:flutter/material.dart';
import 'package:product_list_app/models/cart_item.dart';
class CartDialog extends StatefulWidget {
  const CartDialog({
    super.key,
    required List<CartItem> shopBag,
  }) : _shopBag = shopBag;

  final List<CartItem> _shopBag;

  @override
  State<CartDialog> createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text("Your Cart"),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                "Items in Your Cart",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: widget._shopBag.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        widget._shopBag[index].product.picture,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
    
                      title: Text(
                        widget._shopBag[index].product.name,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        "${widget._shopBag[index].product.cost * widget._shopBag[index].quantity} TL",
                      ),
    
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (widget._shopBag[index].quantity >
                                    1) {
                                  widget._shopBag[index].quantity--;
                                } else {
                                  widget._shopBag.removeAt(index);
                                }
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 18,
                            ),
                          ),
    
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                            child: Text(
                              "${widget._shopBag[index].quantity}",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget._shopBag[index].quantity++;
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              widget._shopBag.clear();
            });
          },
          child: const Text("Clear Cart"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}
