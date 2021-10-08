import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClienteForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de cliente'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // TODO: Fazer validação do form
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();
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
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito curto';
                  }
                  return null;
                },
                onSaved: (value) {
                  print(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "CEP",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.travel_explore),
                    onPressed: () {
                      // FIXME:Realizar importação de dados de endereço
                    },
                  ),
                ),
                validator: (value){
                  if(value.trim().isEmpty || value.length<9){
                    return 'CEP precisa de 9 digitos';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Endereço"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "nº"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Bairro"),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Cidade"),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Estado"),
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
