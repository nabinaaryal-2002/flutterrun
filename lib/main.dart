
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/location/location%20check.dart';
import 'package:fluttersample1/presentation/login_page.dart';
import 'package:fluttersample1/presentation/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:fluttersample1/models/cart_item.dart';

final box = Provider<String?>((ref) => null);
final box1 = Provider<List<CartItem>>((ref) => []);


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());

  final userBox = await Hive.openBox<String>('user');
  final cartBox = await Hive.openBox<CartItem>('carts');

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: appColor
      )
  );

  runApp(ProviderScope(
    overrides: [
      box.overrideWithValue(userBox.get('userData')),
      box1.overrideWithValue(cartBox.values.toList())

    ],
      child: Home()
  ));
}



class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 866),
      minTextAdapt: true,
      builder: (context , child) {
        return GetMaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child:
      // LocationCheck()
      StatusPage()
    );
  }
}
