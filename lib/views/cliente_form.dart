import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:provider/provider.dart';

class ClienteForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  void _loadFormData(Cliente cliente) {
    _formData["id"] = cliente.id;
    _formData["nome"] = cliente.nome;
    _formData["cep"] = cliente.cep;
    _formData["logradouro"] = cliente.logradouro;
    _formData["numero"] = cliente.numero;
    _formData["bairro"] = cliente.bairro;
    _formData["cidade"] = cliente.cidade;
    _formData["estado"] = cliente.estado;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      final cliente = args as Cliente;
      _loadFormData(cliente);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de cliente"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<Clientes>(context, listen: false).put(Cliente(
                  id: _formData["id"] != null ? _formData["id"]! : -1,
                  nome: _formData["nome"]!,
                  cep: _formData["cep"]!,
                  logradouro: _formData["logradouro"]!,
                  numero: _formData["numero"]!,
                  bairro: _formData["bairro"]!,
                  cidade: _formData["cidade"]!,
                  estado: _formData["estado"]!,
                ));
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                onSaved: (value) => _formData["nome"] = value!,
                initialValue: _formData["nome"],
                validator: (value) {
                  return value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 3
                      ? "Nome inválido ou muito curto"
                      : null;
                },
                decoration: InputDecoration(labelText: "Nome"),
                autofocus: true,
              ),
              TextFormField(
                onSaved: (value) => _formData["cep"] = value!,
                initialValue: _formData["cep"],
                validator: (value) {
                  return value!.trim().isEmpty || value.length < 8
                      ? "CEP precisa de 8 digitos"
                      : null;
                },
                decoration: InputDecoration(
                  labelText: "CEP",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.travel_explore),
                    onPressed: () {
                      // TODO Realizar importação de dados de endereço
                    },
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
              ),
              TextFormField(
                onSaved: (value) => _formData["logradouro"] = value!,
                initialValue: _formData["logradouro"],
                validator: (value) {
                  return value!.trim().isEmpty || value.length < 4
                      ? "Endereço muito curto"
                      : null;
                },
                decoration: InputDecoration(labelText: "Endereço"),
              ),
              TextFormField(
                onSaved: (value) => _formData["numero"] = value!,
                initialValue: _formData["numero"],
                validator: (value) {
                  return value!.trim().isEmpty ? "Necessário informar" : null;
                },
                decoration: InputDecoration(labelText: "nº e complemento"),
              ),
              TextFormField(
                onSaved: (value) => _formData["bairro"] = value!,
                initialValue: _formData["bairro"],
                validator: (value) {
                  return value!.trim().isEmpty || value.length < 4
                      ? "Bairro muito curto"
                      : null;
                },
                decoration: InputDecoration(labelText: "Bairro"),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      onSaved: (value) => _formData["cidade"] = value!,
                      initialValue: _formData["cidade"],
                      validator: (value) {
                        return value!.length < 3
                            ? "Nome da cidade muito curto"
                            : null;
                      },
                      decoration: InputDecoration(labelText: "Cidade"),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: TextFormField(
                      onSaved: (value) =>
                          _formData["estado"] = value!.toUpperCase(),
                      initialValue: _formData["estado"],
                      validator: (value) {
                        return value!.length != 2 ? "Informe" : null;
                      },
                      decoration: InputDecoration(labelText: "Estado"),
                      keyboardType: TextInputType.name,
                      inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
