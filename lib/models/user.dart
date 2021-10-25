import 'package:flutter/material.dart';

class User{
  final String? id;
  final String nome;
  final String email;
  final String? avatarUrl;

  const User({
    this.id,
    required this.nome,
    required this.email,
    this.avatarUrl,
  });

}

