import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/livro.dart';

class CarrinhoPage extends StatefulWidget {
  final ValueNotifier<List<Livro>> carrinho;
  final VoidCallback onPagamento;

  const CarrinhoPage({
    super.key,
    required this.carrinho,
    required this.onPagamento,
  });

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  bool carregando = false;

  double calcularTotal(List<Livro> produtos) {
    return produtos.fold<double>(
      0,
          (total, livro) => total + livro.precoNumerico,
    );
  }

  Future<void> removerLivro(Livro livro) async {
    final quantidadeAtual = widget.carrinho.value
        .where((item) => item.id == livro.id)
        .length;

    await DatabaseHelper.instance.alterarQuantidade(
      livro.id,
      quantidadeAtual - 1,
    );

    final produtos = await DatabaseHelper.instance.listarCarrinho();

    widget.carrinho.value = produtos;
  }

  String formatarPreco(double valor) {
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu carrinho',
          style: TextStyle(
            color: Color(0xFF242078),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF4520C9),
        ),
        backgroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<List<Livro>>(
        valueListenable: widget.carrinho,
        builder: (context, produtos, child) {
          if (produtos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 75,
                    color: Color(0xFF4520C9),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Seu carrinho está vazio!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Adicione livros para continuar.'),
                ],
              ),
            );
          }

          final total = calcularTotal(produtos);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final livro = produtos[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: Image.asset(
                          livro.imagem,
                          width: 55,
                          height: 75,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.menu_book,
                              size: 45,
                              color: Color(0xFF4520C9),
                            );
                          },
                        ),
                        title: Text(
                          livro.titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'R\$ ${livro.preco}',
                          style: const TextStyle(
                            color: Color(0xFF4520C9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await removerLivro(livro);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0EEFF),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R\$ ${formatarPreco(total)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4520C9),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onPagamento,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4520C9),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                        ),
                        child: const Text('Continuar para pagamento'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}