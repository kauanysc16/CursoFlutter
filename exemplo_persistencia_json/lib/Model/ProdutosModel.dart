class Produto {
  //atributos
  final String nome;
  final int preco;
  final String categoria;
  //construtor
  const Produto({
    required this.nome,
    required this.preco,
    required this.categoria});
  //métodos
  Map<String,dynamic> toJson() {
    return {
      'nome': nome,
      'preco': preco,
      'categoria': categoria
    };
  }
  factory Produto.fromJson(Map<String,dynamic> json){
    return Produto(
      nome: json['nome'],
      preco: json['preco'],
      categoria: json['categoria']
    );
  }
}