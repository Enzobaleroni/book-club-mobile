import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'database/database_helper.dart';
import 'models/livro.dart';

import 'pages/pagamento_page.dart';
import 'pages/paginaInicial.dart';
import 'pages/recuperarsenha.dart';
import 'pages/telacadastro.dart';
import 'pages/carrinho_page.dart';
import 'pages/detalhes_page.dart';
import 'pages/digitarcodigo.dart';
import 'pages/homepagi.dart';

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> messengerKey =
GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    DatabaseFactory? databaseFactoryFfiWeb;
    databaseFactory = databaseFactoryFfiWeb;
  }

  runApp(const BookClubApp());
}

class BookClubApp extends StatefulWidget {
  const BookClubApp({super.key});

  @override
  State<BookClubApp> createState() => _BookClubAppState();
}

class _BookClubAppState extends State<BookClubApp> {
  late final ValueNotifier<List<Livro>> carrinho =
  ValueNotifier<List<Livro>>([]);

  void abrir(Widget pagina) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => pagina,
      ),
    );
  }

  double calcularTotal() {
    return carrinho.value.fold<double>(
      0,
          (total, livro) => total + livro.precoNumerico,
    );
  }

  Future<void> atualizarCarrinho() async {
    final produtos = await DatabaseHelper.instance.listarCarrinho();

    carrinho.value = produtos;
  }

  Future<void> entrar() async {
    try {
      await atualizarCarrinho();

      abrir(
        HomePage(
          carrinho: carrinho,
          onDetalhes: (livro) {
            abrir(
              DetalhesPage(
                livro: livro,
                onComprar: () async {
                  try {
                    await DatabaseHelper.instance.adicionarCarrinho(
                      livro.id,
                    );

                    await atualizarCarrinho();

                    navigatorKey.currentState?.pop();

                    messengerKey.currentState?.showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Livro adicionado ao carrinho!',
                        ),
                      ),
                    );
                  } catch (erro) {
                    messengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Erro ao adicionar livro: $erro',
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
          onCarrinho: () {
            abrir(
              CarrinhoPage(
                carrinho: carrinho,
                onPagamento: () {
                  if (carrinho.value.isEmpty) {
                    return;
                  }

                  abrir(
                    PagamentoPage(
                      total: calcularTotal(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    } catch (erro) {
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Erro ao abrir a loja: $erro'),
        ),
      );
    }
  }

  @override
  void dispose() {
    carrinho.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Book Club',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF4520C9),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4520C9),
        ),
      ),
      home: LoginPage(
        onLogin: entrar,
        onCadastro: () {
          abrir(
            CadastroPage(
              onCadastro: () {
                navigatorKey.currentState?.pop();
              },
            ),
          );
        },
        onRecuperar: () {
          abrir(
            RecuperarPage(
              onEnviar: (email) {
                abrir(
                  CodigoPage(
                    email: email,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}