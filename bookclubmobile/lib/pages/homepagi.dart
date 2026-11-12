import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/livro.dart';

class HomePage extends StatefulWidget {
  final ValueNotifier<List<Livro>> carrinho;
  final Function(Livro) onDetalhes;
  final VoidCallback onCarrinho;

  const HomePage({
    super.key,
    required this.carrinho,
    required this.onDetalhes,
    required this.onCarrinho,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Livro>> livrosFuture;

  @override
  void initState() {
    super.initState();
    livrosFuture = DatabaseHelper.instance.listarLivros();
  }

  void atualizarLivros() {
    setState(() {
      livrosFuture = DatabaseHelper.instance.listarLivros();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(
              Icons.menu_book,
              color: Color(0xFF4520C9),
            ),
            SizedBox(width: 8),
            Text(
              'BOOK CLUB',
              style: TextStyle(
                color: Color(0xFF242078),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          ValueListenableBuilder<List<Livro>>(
            valueListenable: widget.carrinho,
            builder: (context, produtos, child) {
              return IconButton(
                onPressed: widget.onCarrinho,
                icon: Badge(
                  label: Text('${produtos.length}'),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xFF4520C9),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4520C9),
                  Color(0xFF242078),
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descubra seu próximo livro!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Encontre histórias e conhecimentos incríveis.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Livro>>(
              future: livrosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF4520C9),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Erro ao carregar os livros.'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: atualizarLivros,
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                }

                final livros = snapshot.data ?? [];

                if (livros.isEmpty) {
                  return const Center(
                    child: Text('Nenhum livro cadastrado.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: livros.length,
                  itemBuilder: (context, index) {
                    final livro = livros[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: 125,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0EEFF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  livro.imagem,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.menu_book,
                                      size: 55,
                                      color: Color(0xFF4520C9),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    livro.titulo,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(livro.autor),
                                  const SizedBox(height: 8),
                                  Text(
                                    'R\$ ${livro.preco}',
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4520C9),
                                    ),
                                  ),
                                  Text(
                                    'R\$ ${livro.precoAntigo}',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.onDetalhes(livro);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF4520C9),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('Ver detalhes'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}