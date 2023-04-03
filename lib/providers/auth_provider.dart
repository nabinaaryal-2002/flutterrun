
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fluttersample1/services/auth_service.dart';
import '../models/auth_state.dart';


final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(AuthState.empty()));

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(super.state);


  Future<void> userSignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AuthService.userSignUp(username: username, email: email, password: password,);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }




  Future<void> userLogin({
    required String email,
    required String password
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AuthService.userLogin(email: email, password: password);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }



  void userLogOut(){
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
  }






}