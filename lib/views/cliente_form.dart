import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:medicao/services/via_cep_service.dart';
import 'package:provider/provider.dart';

class ClienteForm extends StatefulWidget {
  @override
  State<ClienteForm> createState() => _ClienteFormState();
}

class _ClienteFormState extends State<ClienteForm> {
  TextEditingController _cepController = TextEditingController();
  TextEditingController _logradouroController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _estadoController = TextEditingController();

  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  void _loadFormData(Cliente cliente) {
    _formData["id"] = cliente.id;
    _formData["nome"] = cliente.nome;
    _formData["numero"] = cliente.numero;
    _cepController.text = cliente.cep;
    _logradouroController.text = cliente.logradouro;
    _bairroController.text = cliente.bairro;
    _cidadeController.text = cliente.cidade;
    _estadoController.text = cliente.estado;
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
          child: SingleChildScrollView(
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
                  validator: (value) {
                    return value!.trim().isEmpty || value.length < 10
                        ? "CEP incompleto"
                        : null;
                  },
                  controller: _cepController,
                  decoration: InputDecoration(
                    labelText: "CEP",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.travel_explore),
                      onPressed: () async {
                        if (_cepController.text.trim().isEmpty ||
                            _cepController.text.length < 10) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text("Consulta CEP"),
                                    content: Text(
                                      'CEP incompleto',
                                      style:
                                          TextStyle(color: Colors.red.shade700),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("OK"))
                                    ],
                                  ));
                        } else {
                          // FIXME tratar resposta para cep incorreto
                          final cep = _cepController.text
                              .replaceAll(RegExp(r'[^\w\s]+'), '');
                          print(cep);
                          try {
                            final resultadoCep =
                                await ViaCep.fetchCep(cep: cep);
                            _logradouroController.text =
                                resultadoCep.logradouro;
                            _bairroController.text = resultadoCep.bairro;
                            _cidadeController.text = resultadoCep.localidade;
                            _estadoController.text = resultadoCep.uf;
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Erro ao importar dados"),
                                content: Text("$e"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text("Ok"),
                                  )
                                ],
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                ),
                TextFormField(
                  controller: _logradouroController,
                  onSaved: (value) => _formData["logradouro"] = value!,
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
                  controller: _bairroController,
                  onSaved: (value) => _formData["bairro"] = value!,
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
                        controller: _cidadeController,
                        onSaved: (value) => _formData["cidade"] = value!,
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
                        controller: _estadoController,
                        onSaved: (value) =>
                            _formData["estado"] = value!.toUpperCase(),
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
      ),
    );
  }
}
