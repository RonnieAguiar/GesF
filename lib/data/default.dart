import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/models/user.dart';

const DEFAULT_USERS = {
  '1': const User(
      nome: 'Usuario 01', email: 'usuario1@user.com', avatarUrl: null),
  '2': const User(
      nome: 'Usuario 02', email: 'usuario2@user.com', avatarUrl: null),
};

const DEFAULT_CLIENTES = {
  1: const Cliente(
      id: 1,
      nome: 'Ed. Danilo Café Carvalhaes',
      cep: '31710090',
      logradouro: 'Rua Ernane Agrícola',
      numero: '17',
      bairro: 'Buritis',
      cidade: 'Belo Horizonte',
      estado: 'MG'),
  2: const Cliente(
      id: 2,
      nome: 'Fantini (Sede)',
      cep: '31710090',
      logradouro: 'Rua Engenheiro Vicente Assunção',
      numero: '148',
      bairro: 'Itapoã',
      cidade: 'Belo Horizonte',
      estado: 'MG'),
};
