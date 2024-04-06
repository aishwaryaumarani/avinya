
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/bottom_nav_screen.dart';
import '../screens/login_screen.dart';

class GoogleProvider extends ChangeNotifier{

  final googlesignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async{

    final googleUser = await googlesignIn.signIn();

    if(googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      Navigator.of(context).pushNamed(BottomNavScreen.routeName);
    });

    notifyListeners();
  }

  Future googleLogout() async{
    await googlesignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  Future createUser(BuildContext context, String email, String pass, String uName) async{
    
    try{

      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass).then((value){
        print("done done ${value.user}");
        value.user!.updateDisplayName(uName);
        Navigator.of(context).pushNamed(BottomNavScreen.routeName);
      });
    }catch(e){
      return e.toString();
    }
  }

  Future siginUser(BuildContext context, String email, String pass) async{
    
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((value){
        print("done done ${value.user}");
        //FirebaseAuth.instance.idTokenChanges()
        Navigator.of(context).pushNamed(BottomNavScreen.routeName);
      });
    }catch(e){
      return e.toString();
    }
  }
  Future forgotPassword(String mails,BuildContext context) async{
    try{

      await _firebaseAuth.sendPasswordResetEmail(email: mails).then((value){
        Navigator.of(context).pushNamed(LoginScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Check Your Email For Furthur Steps")));
      });
    }catch(e){
      return e.toString();
    }
  }
}