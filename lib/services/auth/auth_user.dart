import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class AuthUser {

  final bool isEmailVerified;

  const AuthUser({
    this.isEmailVerified = false,
  });
  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      isEmailVerified: user.emailVerified,
    );
  }
}
