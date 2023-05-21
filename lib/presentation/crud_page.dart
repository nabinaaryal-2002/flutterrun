import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/services/crud_service.dart';
import 'package:fluttersample1/presentation/edit_page.dart';
import 'package:get/get.dart';
import 'package:fluttersample1/presentation/delete_page.dart';


class CrudPage extends ConsumerWidget{


  @override
  Widget build(BuildContext context,ref) {
    final productData = ref.watch(products);
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body:  Container(
          padding:  EdgeInsets.symmetric(horizontal: 10, vertical:10),
          child: productData.when(
              data: (data){
                return ListView.separated(
                  separatorBuilder: (context, index){
                    return SizedBox(height: 20,);
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Image.network(data[index].image, fit: BoxFit.cover,),
                    title: Text (data[index].product_name),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              Get.to(()=> EditPage(data[index]));
                            }, icon: Icon(Icons.edit)),
                            IconButton(onPressed: (){
                              Get.to(()=> DeletePage(data[index]));
                            }, icon: Icon(Icons.delete)),
                          ],

                        ),
                      ),
                    );
                  },
                );
              },
              error: (err, stack)=> Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        )
    );
  }

}
