import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/models/product.dart';
import 'package:fluttersample1/providers/auth_provider.dart';
import 'package:fluttersample1/providers/crud_provider.dart';
import 'package:fluttersample1/services/crud_service.dart';
import 'package:get/get.dart';

class DeletePage extends ConsumerWidget {
  final Product product;

  DeletePage(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Page'),
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
                          await CrudService().deleteProduct(
                            productId: product.productId,
                            token: auth.user!.token,
                          );
                          ref.read(crudProvider.notifier).refreshProducts(); // Refresh the product list after deletion
                          Get.back(); // Go back to the previous page
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










































