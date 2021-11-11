
class Cliente {
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

  final int id;
  final String nome;
  final String cep;
  final String logradouro;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json["id"],
      nome: json["nome"],
      cep: json["cep"],
      logradouro: json["logradouro"],
      numero: json["numero"],
      bairro: json["bairro"],
      cidade: json["cidade"],
      estado: json["estado"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "cep": cep,
        "logradouro": logradouro,
        "numero": numero,
        "bairro": bairro,
        "cidade": cidade,
        "estado": estado,
      };

  static String enderecador(Cliente cliente) {
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
