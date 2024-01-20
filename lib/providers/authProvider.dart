// ignore_for_file: file_names, avoid_debugPrint, constant_identifier_names, unnecessary_null_comparison

// ignore: import_of_legacy_library_into_null_safe
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unAuthenticated, Authenticated, loading }

class AuthProvider with ChangeNotifier {
  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  AuthStatus _authStatus = AuthStatus.unAuthenticated;
  String? error;

  AuthStatus get authStatus => _authStatus;

  String phone = '';

  auth() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        log(' AuthProvider user=null');
      } else {
        _user = user;
        log('AuthProvider user=$user');
      }
      debugPrint('AuthProvider  done');
      notifyListeners();
    });
  }

  Future<bool> logIn() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _user = value.user);

      setPref(email, password);
      debugPrint('login done');

      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        error = 'invalid-email';
      }
      if (e.code == 'user-disabled') {
        error = 'user-disabled';
      }
      if (e.code == 'user-not-found') {
        error = 'user-not-found';
      }
      if (e.code == 'wrong-password') {
        error = 'wrong-password';
      } else {
        debugPrint(e.toString());
      }
      debugPrint('no');
      _authStatus = AuthStatus.unAuthenticated;
      notifyListeners();

      return false;
    }
  }

  Future<bool> register() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _user = value.user);
      _authStatus = AuthStatus.Authenticated;

      notifyListeners();

      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        error = 'weak_password';
      }
      if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
      }
      if (e.code == 'invalid-email') {
        error = 'invalid-email';
      }
      _authStatus = AuthStatus.unAuthenticated;

      notifyListeners();

      return false;
    }
  }

  logout() async {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    removePref();
    debugPrint('logged out');

    notifyListeners();
  }

  Future sendLink() async {
    if (!user!.emailVerified) {
      await user!.sendEmailVerification();
      debugPrint('email sent');
    } else {
      error = 'you are already verified';
    }

    notifyListeners();
  }

  loginAnonymously() async {
    await _auth.signInAnonymously();
    _authStatus = AuthStatus.Authenticated;
    notifyListeners();
  }

  forgetPassword() async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
    await _auth.confirmPasswordReset(code: '', newPassword: '');
  }

  setPref(email, password) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('login', true);
    pref.setString('email', email);
    pref.setString('password', password);
    debugPrint('prefs has been created');
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    email = pref.getString('email')!;
    password = pref.getString('password')!;
    debugPrint('get pref done');
  }

  removePref() async {
    var pref = await SharedPreferences.getInstance();

    pref.remove('login');
    pref.remove('email');
    pref.remove('password');
    debugPrint('prefs deleted');
  }

  setPrefPhone() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('login', true);
    pref.setString('id', _user!.uid);
    debugPrint('Phone prefs added ');
  }

  removePrefPhone() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('login');
    pref.remove('id');

    debugPrint('prefs deleted');
  }
}

class Auth {
  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  String? error;

  String phone = '';

  auth() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('user1=null');
      } else {
        _user = user;
        log('user1=$user');
      }
      debugPrint('auth done');
    });
  }

  Future<bool> logIn() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _user = value.user);

      setPref(email, password);
      debugPrint('login done');

      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        error = 'invalid-email';
      }
      if (e.code == 'user-disabled') {
        error = 'user-disabled';
      }
      if (e.code == 'user-not-found') {
        error = 'user-not-found';
      }
      if (e.code == 'wrong-password') {
        error = 'wrong-password';
      } else {
        debugPrint(e.toString());
      }

      return false;
    }
  }

  Future<bool> register() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _user = value.user);

      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        error = 'weak_password';
      }
      if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
      }
      if (e.code == 'invalid-email') {
        error = 'invalid-email';
      }

      return false;
    }
  }

  logout() async {
    await _auth.signOut();
    removePref();
    debugPrint('logged out');
  }

  Future sendLink({User? user}) async {
    if (!user!.emailVerified) {
      await user.sendEmailVerification();
      debugPrint('email sent');
    } else {
      error = 'you are already verified';
    }
  }

  loginAnonymously() async {
    await _auth.signInAnonymously();
  }

  forgetPassword() async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
    await _auth.verifyPasswordResetCode('');
    await _auth.confirmPasswordReset(code: '', newPassword: '');

    user!.updatePassword('');
  }

  setPref(email, password) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('login', true);
    pref.setString('email', email);
    pref.setString('password', password);
    debugPrint('prefs has been created');
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    email = pref.getString('email')!;
    password = pref.getString('password')!;
    debugPrint('get pref done');
  }

  removePref() async {
    var pref = await SharedPreferences.getInstance();

    pref.remove('login');
    pref.remove('email');
    pref.remove('password');
    debugPrint('prefs deleted');
  }

  setPrefPhone() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('login', true);
    pref.setString('id', _user!.uid);
    debugPrint('Phone prefs added ');
  }

  removePrefPhone() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('login');
    pref.remove('id');

    debugPrint('prefs deleted');
  }
}

/*

class Auth{
  String email='';
  String password='';
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;
  AuthStatus _authStatus=AuthStatus.unAuthenticated;
  String?  error;
  AuthStatus get authStatus=>_authStatus;

  User? get user=> _user;

  String phone='';
  bool goo=false;


  auth(){

    _auth.authStateChanges().listen((User? user) {
      if (user==null){_authStatus==AuthStatus.unAuthenticated;}
      else{_user=user;}
      debugPrint('auth2 done');

    });
  }

  Future<bool>logIn({required String email ,required String password})async{
    try{

      await _auth.signInWithEmailAndPassword(email:email , password:password ).then((value) =>  _user=value.user);
      _authStatus=AuthStatus.Authenticated;


      setPref(email,password);
      debugPrint('login2 done');




      return true;

    }on FirebaseException catch(e){
      if(e.code=='invalid-email'){error='invalid-email';}
      if(e.code=='user-disabled'){error='user-disabled';}
      if(e.code=='user-not-found'){error='user-not-found';}
      if(e.code=='wrong-password'){error='wrong-password';}

      _authStatus=AuthStatus.unAuthenticated;


      return false;
    }
  }

  Future <bool>register()async{

    try{

      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _authStatus=AuthStatus.Authenticated;



      return true;


    } on FirebaseException  catch(e){
      if(e.code=='weak-password'){error='weak_password';}
      if(e.code=='email-already-in-use'){error='email-already-in-use';}
      if(e.code=='invalid-email'){error='invalid-email';}
      _authStatus=AuthStatus.unAuthenticated;



      return false;

    }
  }

  logout()async{
    await _auth.signOut();
    _authStatus=AuthStatus.unAuthenticated;
    removePref();

  }

  Future sendLink()async{

    if( !user!.emailVerified){await user!.sendEmailVerification();} else{error='you are already verified';}


  }

  loginAnonymously()async{
    await _auth.signInAnonymously();
    _authStatus=AuthStatus.Authenticated;

  }



  func()async{





  }


  setPref(email,password)async {
    var pref=await SharedPreferences.getInstance();
    pref.setBool('login',true);
    pref.setString('email', email);
    pref.setString('password', password);
    debugPrint('pref set');


  }
  getPref()async{
    var pref=await SharedPreferences.getInstance();
    email=pref.getString('email')!;
    password=pref.getString('password')!;
    debugPrint('get pref done');

  }









  removePref()async{
    var pref=await SharedPreferences.getInstance();

    debugPrint('pref removed');
    pref.remove('login');
    pref.remove('email');
    pref.remove('password');

  }





}*/
