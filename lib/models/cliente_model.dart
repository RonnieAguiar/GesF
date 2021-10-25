
class Cliente {
  final int id;
  final String nome;
  final String cep;
  final String logradouro;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;

  const Cliente({
    required this.id,
    required this.nome,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });
}
