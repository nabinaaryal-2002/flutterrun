// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttersample1/presentation/auth_page.dart';
// import 'package:fluttersample1/presentation/home_page.dart';
// import 'package:fluttersample1/providers/auth_provider.dart';
//
//
//
// class StatusPage extends ConsumerWidget {
//
//
//   @override
//   Widget build(BuildContext context, ref) {
//     final auth = ref.watch(authStream);
//     return Container(
//         child:auth.when(
//             data: (data){
//               if(data == null){
//                 return AuthPage();
//               }else{
//                 return HomePage();
//               }
//             },
//             error: (err, stack) => Center(child: Text('$err')),
//             loading: () => Center(child: CircularProgressIndicator())
//         )
//     );
//   }
// }