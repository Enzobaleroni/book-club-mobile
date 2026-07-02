import 'package:flutter/material.dart';

class Homepagi extends StatefulWidget {
  const Homepagi({super.key});

  @override
  State<Homepagi> createState() => _HomepagiState();
}

class _HomepagiState extends State<Homepagi> {

  Widget livroCard({
    required String imagem,
    required String titulo,
    required String autor,
    required String preco,
    required String precoAntigo,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imagem,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  autor,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: List.generate(
                    5,
                        (index) => const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Text(
                      preco,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4338CA),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      precoAntigo,
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration:
                        TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                const Text(
                  'Pagamento via pix ou cartão',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Entrega gratuita',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF4338CA),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25),
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // CABEÇALHO
              Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [

                    Image.asset(
                      'assets/logo_book2.png',
                      width: 50,
                      height: 50,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Pesquisar...',
                            prefixIcon:
                            Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 35,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),

              // BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4F46E5),
                      Color(0xFF312E81),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Descubra seu próximo\nlivro favorito',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Milhares de títulos para expandir seus horizontes.',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.white,
                        foregroundColor:
                        const Color(0xFF4338CA),
                      ),
                      child: const Text(
                        'Explorar Livros',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              livroCard(
                imagem: 'assets/imagem.png',
                titulo:
                'Como convencer alguém em 90 segundos',
                autor: 'Nicholas Boothman',
                preco: 'R\$ 33,17',
                precoAntigo: 'R\$ 39,90',
              ),

              livroCard(
                imagem: 'assets/imagem-da-persuasão.jpg',
                titulo: 'As armas da persuasão',
                autor: 'Robert B. Cialdini',
                preco: 'R\$ 87,33',
                precoAntigo: '',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}