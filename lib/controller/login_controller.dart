import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), //trim ajuda a formatar o texto
        password: password.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Senha incorreta';
      } else if (e.code == 'user-not-found') {
        return 'Usuário não encontrado';
      } else {
        return 'Erro desconhecido';
      }
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    if (passwordConfirmed(
        password: password, confirmpasswordcontroller: password)) {
      // cadastrar usuário
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), //trim ajuda a formatar o texto
          password: password.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return 'A senha fornecida é muito fraca.';
        } else if (e.code == 'email-already-in-use') {
          return 'A conta já existe para esse e-mail.';
        }
      }
    }
    return null;
  }

  Future addUserDetails(
    String firstName,
    String lastName,
    String email,
    int age,
  ) async {
    await FirebaseFirestore.instance.collection('users').add(
      {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'age': age,
      },
    );
  }

  bool passwordConfirmed(
      {required String password, required String confirmpasswordcontroller}) {
    if (password.trim() == confirmpasswordcontroller.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }
}
