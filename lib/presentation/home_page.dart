
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fluttersample1/providers/auth_provider.dart';
import 'package:get/get.dart';
import 'package:fluttersample1/presentation/create_page.dart';
class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    FlutterNativeSplash.remove();

    return Scaffold(
        appBar: AppBar(
          title: Text('Shop App'),
        ),
        drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text(auth.user!.email),
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  leading: Icon(Icons.email),
                  title: Text(auth.user!.email),
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    Get.to(() => CreatePage(), transition: Transition.leftToRight);
                  },
                  leading: Icon(Icons.add),
                  title: Text('Create Product'),
                ),

                ListTile(
                  onTap: (){
                     ref.read(authProvider.notifier).userLogOut();
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                )
              ],
            )

        ),
        body:  Container()
    );
  }
}