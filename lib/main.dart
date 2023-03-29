
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:fluttersample1/providers/counter_provider.dart';
import 'package:get/get.dart';




void main(){
SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor:appColor
    )
);
runApp(ProviderScope(child: Home()));
}


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
 return ScreenUtilInit(
   designSize: const Size(411, 866),
   minTextAdapt: true,
   builder: (context , child) {
     return GetMaterialApp(
       debugShowCheckedModeBanner: false,
       home: child,
     );
   },
   child: Count(),
 );

  }
}

class Count extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    print('build start');
    return Scaffold(
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final number = ref.watch(counterProvider).number;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${number} ', style: TextStyle(fontSize: 50),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider).addNumber();
                          },
                          child: Text('add')
                      ),
                      SizedBox(width: 20,),

                      ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider).minusNumber();
                          },
                          child: Text('minus')
                      )
                    ],
                  )
                ],
              );
            }
          ),
        ),
    );
  }
}
