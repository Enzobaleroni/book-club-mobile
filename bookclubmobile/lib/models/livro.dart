class Livro {
  final int id;
  final String titulo;
  final String autor;
  final String categoria;
  final String preco;
  final String precoAntigo;
  final String descricao;
  final String imagem;
  final double avaliacao;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.preco,
    required this.precoAntigo,
    required this.descricao,
    required this.imagem,
    required this.avaliacao,
  });

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      id: map['id'] as int,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      categoria: map['categoria'] ?? '',
      preco: map['preco']?.toString() ?? '0,00',
      precoAntigo: map['preco_antigo']?.toString() ?? '0,00',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
      avaliacao: (map['avaliacao'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'categoria': categoria,
      'preco': preco,
      'preco_antigo': precoAntigo,
      'descricao': descricao,
      'imagem': imagem,
      'avaliacao': avaliacao,
    };
  }

  double get precoNumerico {
    return double.tryParse(
      preco.replaceAll('.', '').replaceAll(',', '.'),
    ) ??
        0.0;
  }
}