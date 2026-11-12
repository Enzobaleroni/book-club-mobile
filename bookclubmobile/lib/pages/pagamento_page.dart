
import 'package:flutter/material.dart';

class PagamentoPage extends StatefulWidget {
  final double total;

  const PagamentoPage({
    super.key,
    required this.total,
  });

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  String metodoPagamento = 'pix';

  String formatarPreco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void confirmarPagamento() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pagamento'),
          content: const Text(
            'Sua forma de pagamento foi selecionada!\n\n'
                'Para realizar uma cobrança real, '
                'é necessário conectar o Book Club '
                'a um gateway de pagamento.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Entendi',
                style: TextStyle(
                  color: Color(0xFF4520C9),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),

      appBar: AppBar(
        title: const Text('Pagamento'),
        backgroundColor: const Color(0xFFFCF8FF),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // RESUMO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4520C9),
                    Color(0xFF242078),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total da compra',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    formatarPreco(widget.total),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'BOOK CLUB',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Escolha a forma de pagamento',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF242078),
              ),
            ),

            const SizedBox(height: 18),

            // OPÇÃO PIX
            GestureDetector(
              onTap: () {
                setState(() {
                  metodoPagamento = 'pix';
                });
              },

              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: metodoPagamento == 'pix'
                        ? const Color(0xFF4520C9)
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.pix,
                      size: 38,
                      color: Color(0xFF4520C9),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pix',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Pagamento instantâneo',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Radio<String>(
                      value: 'pix',
                      groupValue: metodoPagamento,
                      activeColor: const Color(0xFF4520C9),
                      onChanged: (valor) {
                        setState(() {
                          metodoPagamento = valor!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // OPÇÃO CARTÃO
            GestureDetector(
              onTap: () {
                setState(() {
                  metodoPagamento = 'cartao';
                });
              },

              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: metodoPagamento == 'cartao'
                        ? const Color(0xFF4520C9)
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.credit_card,
                      size: 38,
                      color: Color(0xFF4520C9),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cartão virtual',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Pagamento com cartão',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Radio<String>(
                      value: 'cartao',
                      groupValue: metodoPagamento,
                      activeColor: const Color(0xFF4520C9),
                      onChanged: (valor) {
                        setState(() {
                          metodoPagamento = valor!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // INFORMAÇÕES DA MODALIDADE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFF0EEFF),
                borderRadius: BorderRadius.circular(12),
              ),

              child: metodoPagamento == 'pix'
                  ? const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pix,
                        color: Color(0xFF4520C9),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Pagamento via Pix',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Após a integração com o serviço de pagamento, '
                        'será gerado um QR Code Pix exclusivo para '
                        'esta compra.',
                    style: TextStyle(height: 1.5),
                  ),
                ],
              )
                  : const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: Color(0xFF4520C9),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Pagamento com cartão',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    'O pagamento será processado por um '
                        'serviço seguro de pagamentos. Os dados '
                        'do cartão deverão ser informados '
                        'diretamente nesse serviço.',
                    style: TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // BOTÃO CONFIRMAR
            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: confirmarPagamento,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4520C9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: const Text(
                  'Continuar para pagamento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Center(
              child: Text(
                'Book Club - Pagamento seguro',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
