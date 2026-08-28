import 'package:flutter/material.dart';

void main() {
  runApp(const BookClubApp());
}

class BookClubApp extends StatelessWidget {
  const BookClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF4361EE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4361EE),
          secondary: const Color(0xFFF72585),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// Modelo simples para os livros
class Book {
  final String name;
  final double price;
  final double? oldPrice;
  final String category;
  final String imageUrl; // Use URL de placeholder ou asset
  final double rating;
  final String badge;
  final String detailPage; // poderia ser a rota da página de detalhes

  Book({
    required this.name,
    required this.price,
    this.oldPrice,
    required this.category,
    required this.imageUrl,
    required this.rating,
    this.badge = '',
    this.detailPage = '',
  });
}

// Página inicial com toda a rolagem
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> books = [
    Book(
      name: 'Como Convencer Alguém em 90 Segundos',
      price: 33.17,
      oldPrice: 39.90,
      category: 'Negócios',
      imageUrl: 'https://via.placeholder.com/150x200/4361EE/FFFFFF?text=90s',
      rating: 4.5,
      badge: 'Mais vendido',
    ),
    Book(
      name: 'As Armas da Persuasão',
      price: 87.33,
      category: 'Psicologia',
      imageUrl: 'https://via.placeholder.com/150x200/F72585/FFFFFF?text=Armas',
      rating: 4.0,
    ),
    Book(
      name: 'Gatilhos Mentais',
      price: 60.70,
      oldPrice: 79.90,
      category: 'Marketing',
      imageUrl:
      'https://via.placeholder.com/150x200/3A0CA3/FFFFFF?text=Gatilhos',
      rating: 5.0,
      badge: 'Oferta',
    ),
    Book(
      name: 'A Máquina Definitiva de Vendas',
      price: 280.00,
      category: 'Vendas',
      imageUrl:
      'https://via.placeholder.com/150x200/7209B7/FFFFFF?text=Máquina',
      rating: 4.5,
    ),
    Book(
      name: 'A Arte Da Guerra',
      price: 49.90,
      category: 'Estratégia',
      imageUrl: 'https://via.placeholder.com/150x200/4CC9F0/FFFFFF?text=Arte',
      rating: 5.0,
      badge: 'Clássico',
    ),
    Book(
      name: 'O Poder do Hábito',
      price: 44.90,
      category: 'Autoajuda',
      imageUrl: 'https://via.placeholder.com/150x200/6C757D/FFFFFF?text=Hábito',
      rating: 4.5,
    ),
    Book(
      name: 'Mindset',
      price: 39.90,
      category: 'Desenvolvimento',
      imageUrl:
      'https://via.placeholder.com/150x200/212529/FFFFFF?text=Mindset',
      rating: 4.0,
      badge: 'Novo',
    ),
    Book(
      name: 'Os 7 Hábitos das Pessoas Altamente Eficazes',
      price: 55.00,
      category: 'Produtividade',
      imageUrl: 'https://via.placeholder.com/150x200/4361EE/FFFFFF?text=7Hábitos',
      rating: 5.0,
    ),
  ];

  List<Book> filteredBooks = [];
  List<Map<String, dynamic>> cart = []; // {book, quantity}

  @override
  void initState() {
    super.initState();
    filteredBooks = List.from(books);
    _searchController.addListener(_filterBooks);
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredBooks = List.from(books);
      } else {
        filteredBooks = books
            .where((book) => book.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _addToCart(Book book) {
    setState(() {
      final index = cart.indexWhere((item) => item['book'] == book);
      if (index >= 0) {
        cart[index]['quantity']++;
      } else {
        cart.add({'book': book, 'quantity': 1});
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${book.name} adicionado ao carrinho!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cart: cart),
      ),
    ).then((_) => setState(() {})); // atualiza ao voltar
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar com busca e ícone do carrinho
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 80,
            backgroundColor: Colors.white,
            elevation: 2,
            title: Row(
              children: [
                Image.asset(
                  'assets/logo_book2.png', // substitua pelo seu logo
                  height: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  'Book Club',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Color(0xFF4361EE), Color(0xFFF72585)],
                      ).createShader(const Rect.fromLTWH(0, 0, 100, 20)),
                  ),
                ),
              ],
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: _openCart,
                  ),
                  if (cart.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF72585),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.fold<int>(0, (sum, item) => sum + (item['quantity'] as int))}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar livros...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
          ),

          // Hero Section
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4361EE), Color(0xFF3A0CA3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: Image.network(
                      'https://via.placeholder.com/200x300/F72585/FFFFFF?text=Book',
                      height: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Descubra seu próximo livro favorito',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Milhares de títulos para expandir seus horizontes.',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4361EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Explorar Livros'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Título "Nossos Best-sellers"
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                children: [
                  const Text(
                    'Nossos Best-sellers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Os livros mais amados pelos nossos leitores',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          // Grade de produtos
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final book = filteredBooks[index];
                  return _buildProductCard(book);
                },
                childCount: filteredBooks.length,
              ),
            ),
          ),

          // Newsletter
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3A0CA3), Color(0xFF7209B7)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Assine nossa newsletter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Receba novidades e promoções exclusivas.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Seu melhor e-mail',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF72585),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                        ),
                        child: const Text('Assinar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Rodapé
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF212529),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _footerTitle('ATENDIMENTO'),
                            _footerLink('Central de Ajuda'),
                            _footerLink('Métodos de Pagamento'),
                            _footerLink('Garantia Book Club'),
                            _footerLink('Devolução e Reembolso'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _footerTitle('SOBRE NÓS'),
                            _footerLink('Sobre Nós'),
                            _footerLink('Política de Privacidade'),
                            _footerLink('Ofertas'),
                            _footerLink('Book Club BLOG'),
                            _footerLink('Imprensa'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _socialIcon(Icons.facebook),
                      _socialIcon(Icons.camera_alt), // Instagram placeholder
                      _socialIcon(Icons.alternate_email), // Twitter placeholder
                      _socialIcon(Icons.play_circle_fill), // YouTube placeholder
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '© 2025 Book Club. Todos os direitos reservados.',
                    style: TextStyle(color: Colors.white38),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Book book) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  book.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (book.badge.isNotEmpty)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF72585),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      book.badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, size: 18),
                  onPressed: () {},
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ...List.generate(
                      5,
                          (index) => Icon(
                        index < book.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        size: 14,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${book.rating})',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'R\$ ${book.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF4361EE),
                      ),
                    ),
                    if (book.oldPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        'R\$ ${book.oldPrice!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _addToCart(book),
                    icon: const Icon(Icons.shopping_cart, size: 16),
                    label: const Text('Adicionar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4361EE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
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

  Widget _footerTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

// Página simples do carrinho
class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          final book = item['book'] as Book;
          final quantity = item['quantity'] as int;
          return Card(
            child: ListTile(
              leading: Image.network(book.imageUrl, width: 50),
              title: Text(book.name),
              subtitle: Text('Qtd: $quantity'),
              trailing: Text(
                'R\$ ${(book.price * quantity).toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}