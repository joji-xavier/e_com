import 'package:e_com/app/modules/admin/views/admin_view.dart';
import 'package:e_com/app/modules/home/views/home_view.dart';
import 'package:e_com/app/modules/login/controllers/login_controller.dart';
import 'package:e_com/app/modules/login/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final box = GetStorage();
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeView();
        } else if (box.read('Login') != null) {
          return AdminView();
        } else {
          Get.lazyPut(() => LoginController());
          return LoginView();
        }
      },
    );
  }

  signIn() async {
    final GoogleSignInAccount? user =
        await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication auth = await user!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signUp() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    signIn();
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
