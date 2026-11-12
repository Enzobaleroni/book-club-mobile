import 'package:flutter/material.dart';
import '../models/livro.dart';

class DetalhesPage extends StatelessWidget {
  final Livro livro;
  final VoidCallback onComprar;

  const DetalhesPage({
    super.key,
    required this.livro,
    required this.onComprar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do livro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 240,
                width: 170,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EEFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book,
                  size: 100,
                  color: Color(0xFF4520C9),
                ),
              ),
            ),
            const SizedBox(height: 25),

            Text(
              livro.titulo,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF242078),
              ),
            ),

            const SizedBox(height: 8),
            Text('Autor: ${livro.autor}'),

            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(' ${livro.avaliacao}'),
              ],
            ),

            const SizedBox(height: 25),
            const Text(
              'Descrição',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              livro.descricao,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),

            const SizedBox(height: 25),

            Text(
              'R\$ ${livro.preco}',
              style: const TextStyle(
                fontSize: 27,
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

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: onComprar,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Adicionar ao carrinho'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4520C9),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}