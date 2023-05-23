


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/models/product.dart';
import 'package:fluttersample1/providers/auth_provider.dart';
import 'package:fluttersample1/providers/crud_provider.dart';
import 'package:fluttersample1/services/crud_service.dart';
import 'package:get/get.dart';
import '../services/crud_service.dart';

class DeletePage extends ConsumerWidget {
  final Product product;

  DeletePage(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.fireplace_rounded,color: Colors.black,),
            SizedBox(width: 10),
            Text('Shop App',style: TextStyle(fontSize: 25, color: Colors.black ),),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete this product?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Do you really want to delete this product?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await CrudService.deletePost(
                            postId: product.productId,
                            token: auth.user!.token,
                            imageId: '',
                          );
                          ref.read(crudProvider.notifier).refreshProducts(); // Refresh the product list after deletion
                          navigator.maybePop(); // Go back to the previous page
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Text('Delete Product'),
            ),
          ],
        ),
      ),
    );
  }
}








