import 'dart:convert';

class Cliente {
  int id;
  String nome;
  String cep;
  String logradouro;
  String numero;
  String bairro;
  String cidade;
  String estado;

  Cliente({
    required this.id,
    required this.nome,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nome: json["nome"],
        cep: json["cep"],
        logradouro: json["logradouro"],
        numero: json["numero"],
        bairro: json["bairro"],
        cidade: json["cidade"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "cep": cep,
        "logradouro": logradouro,
        "numero": numero,
        "bairro": bairro,
        "cidade": cidade,
        "estado": estado,
      };

  String enderecador(Cliente cliente) {
    String endereco = cliente.logradouro +
        ", " +
        cliente.numero +
        ' - ' +
        cliente.bairro +
        ', ' +
        cliente.cidade +
        '/' +
        cliente.estado +
        ' - CEP: ' +
        cliente.cep;
    return endereco;
  }
}
