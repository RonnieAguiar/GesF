import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:provider/provider.dart';

class ClienteForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de cliente'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // TODO Fazer validação do form
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<Clientes>(context, listen: false).put(Cliente(
                  id: _formData['id'] != null
                      ? int.parse(_formData['id']!)
                      : -1,
                  nome: _formData['nome']!,
                  cep: _formData['cep']!,
                  logradouro: _formData['logradouro']!,
                  numero: _formData['numero']!,
                  bairro: _formData['bairro']!,
                  cidade: _formData['cidade']!,
                  estado: _formData['estado']!,
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
                onSaved: (value) => _formData['nome'] = value!,
                validator: (value) {
                  return value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 3
                      ? 'Nome inválido ou muito curto'
                      : null;
                },
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                onSaved: (value) => _formData['cep'] = value!,
                validator: (value) {
                  return value!.trim().isEmpty || value.length < 8
                      ? 'CEP precisa de 8 digitos'
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
                onSaved: (value) => _formData['logradouro'] = value!,
                validator: (value) {
                  return value!.trim().isEmpty || value.length < 4
                      ? 'Endereço muito curto'
                      : null;
                },
                decoration: InputDecoration(labelText: "Endereço"),
              ),
              TextFormField(
                onSaved: (value) => _formData['numero'] = value!,
                validator: (value) {
                  return value!.trim().isEmpty ? 'Necessário informar' : null;
                },
                decoration: InputDecoration(labelText: "nº e complemento"),
              ),
              TextFormField(
                onSaved: (value) => _formData['bairro'] = value!,
                validator: (value) {
                  return value!.trim().isEmpty || value.length < 4
                      ? 'Bairro muito curto'
                      : null;
                },
                decoration: InputDecoration(labelText: "Bairro"),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      onSaved: (value) => _formData['cidade'] = value!,
                      validator: (value) {
                        return value!.length < 3
                            ? 'Nome da cidade muito curto'
                            : null;
                      },
                      decoration: InputDecoration(labelText: "Cidade"),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: TextFormField(
                      onSaved: (value) =>
                          _formData['estado'] = value!.toUpperCase(),
                      validator: (value) {
                        return value!.length != 2 ? 'Informe' : null;
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
