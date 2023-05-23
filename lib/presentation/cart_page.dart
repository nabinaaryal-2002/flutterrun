
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/providers/auth_provider.dart';
import 'package:fluttersample1/providers/cart_provider.dart';

import '../providers/order_provider.dart';


class CartPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final total = ref.watch(cartProvider.notifier).total;
    final userData = ref.watch(authProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
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


        body: SafeArea(
            child: cartData.isEmpty ? Center(child: Text('Add Some Product To cart')):
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: cartData.length,
                          itemBuilder:(context, index){
                            final cart = cartData[index];
                            return Row(
                              children: [
                                Image.network(cart.productImage, height: 150,width: 150,fit: BoxFit.cover,),
                                Spacer(),
                                Container(
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(onPressed: (){
                                            ref.read(cartProvider.notifier).removeFromCart(cart);
                                          },icon: Icon(Icons.close),)),
                                      Container(
                                        margin: EdgeInsets.only(top: 50),
                                        child: Column(
                                          children: [
                                            Text(cart.productName),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Text('Rs. ${cart.price}'),
                                            ),
                                            Row(
                                              children: [
                                                OutlinedButton(onPressed: (){
                                                  ref.read(cartProvider.notifier).singleAdd(cart);
                                                }, child: Icon(Icons.add)),
                                                Text('X  ${cart.quantity}'),
                                                OutlinedButton(onPressed: (){
                                                  ref.read(cartProvider.notifier).singleRemove(cart);
                                                }, child:Icon(Icons.remove)),
                                              ],
                                            )
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:-'),
                            Text('$total')
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async{
                            setState(() {
                              isLoad = true;
                            });
                            final response = await ref.read(order).orderCreate(total, cartData, userData.user!.id, userData.user!.token);
                            setState(() {
                              isLoad = false;
                            });

                            if(response == 'success'){
                              ref.read(cartProvider.notifier).cartClear();
                            }


                          }, child: isLoad ? Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      )): Text('CheckOut'))
                    ],
                  )
                ],
              ),
            )
        )
    );
  }
}