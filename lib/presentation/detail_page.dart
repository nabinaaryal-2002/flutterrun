import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/models/product.dart';
import 'package:fluttersample1/providers/cart_provider.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              product.image,
                              height: 500,
                              width: 150,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product.product_name,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Rs. ${product.price}',
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(product.product_detail),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Consumer(builder: (context, ref, child) {
                        return ElevatedButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier).addToCart(product, context);
                            }, child: Text('Add To Cart'));
                      }),
                    ),
                  )
                ],
              ),
            )));
  }
}