import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();

    return Scaffold(
        appBar: AppBar(
          title: Text('Sample Shop'),
        ),
        drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: null,
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  // leading: Icon(Icons.email),
                  // title: Text(data.metadata!['email']),
                ),
                ListTile(
                  onTap: (){
                    // Navigator.of(context).pop();
                    // Get.to(() => CreatePage(), transition: Transition.leftToRight);
                  },
                  leading: Icon(Icons.add),
                  title: Text('Create Product'),
                ),

                ListTile(
                  onTap: (){
                    // ref.read(authProvider.notifier).userLogOut();
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