
import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onCadastro;
  final VoidCallback onRecuperar;

  const LoginPage({
    super.key,
    required this.onLogin,
    required this.onCadastro,
    required this.onRecuperar,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool ocultarSenha = true;
  bool carregando = false;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  // ==========================================
  // FAZER LOGIN COM SQLITE
  // ==========================================

  Future<void> fazerLogin() async {
    final email = emailController.text.trim();
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      mostrarMensagem('Preencha seu e-mail e sua senha!');
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      mostrarMensagem('Digite um e-mail válido!');
      return;
    }

    if (senha.length < 6) {
      mostrarMensagem(
        'A senha precisa ter pelo menos 6 caracteres!',
      );
      return;
    }

    setState(() {
      carregando = true;
    });

    try {
      final autenticado =
      await DatabaseHelper.instance.autenticarUsuario(
        email,
        senha,
      );

      if (!mounted) return;

      if (autenticado) {
        widget.onLogin();
      } else {
        mostrarMensagem('E-mail ou senha incorretos!');
      }
    } catch (erro) {
      if (!mounted) return;

      mostrarMensagem('Erro ao realizar login: $erro');
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  // ==========================================
  // MENSAGENS
  // ==========================================

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================
  // INTERFACE
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 35),

                const Icon(
                  Icons.menu_book,
                  size: 65,
                  color: Color(0xFF4520C9),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Faça seu login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242078),
                  ),
                ),

                const SizedBox(height: 45),

                // E-MAIL

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: const Color(0xFFF0EEFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // SENHA

                TextField(
                  controller: senhaController,
                  obscureText: ocultarSenha,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          ocultarSenha = !ocultarSenha;
                        });
                      },
                      icon: Icon(
                        ocultarSenha
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),

                    filled: true,
                    fillColor: const Color(0xFFF0EEFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) {
                    if (!carregando) fazerLogin();
                  },
                ),

                // RECUPERAR SENHA

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: carregando
                        ? null
                        : widget.onRecuperar,
                    child: const Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        color: Color(0xFF4520C9),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // BOTÃO ENTRAR

                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: carregando ? null : fazerLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4520C9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: carregando
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // GOOGLE

                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      mostrarMensagem(
                        'Login com Google ainda não configurado.',
                      );
                    },
                    icon: const Icon(
                      Icons.g_mobiledata,
                      color: Color(0xFF242078),
                    ),
                    label: const Text(
                      'Entrar com Google',
                      style: TextStyle(
                        color: Color(0xFF242078),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // CADASTRO

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não tem uma conta?'),

                    TextButton(
                      onPressed: carregando
                          ? null
                          : widget.onCadastro,
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: Color(0xFF4520C9),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
