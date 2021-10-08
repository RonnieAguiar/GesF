import 'package:flutter/material.dart';

class Responsavel {
  final int id;
  final bool residente;
  final int tipoResponsavelId;
  final int clienteId;

  Responsavel({
    this.id,
    @required this.residente,
    @required this.tipoResponsavelId,
    @required this.clienteId,
  });
}
