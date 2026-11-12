
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  final VoidCallback onCadastro;

  const CadastroPage({
    super.key,
    required this.onCadastro,
  });

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmar = TextEditingController();

  bool ocultarSenha = true;
  bool ocultarConfirmacao = true;

  @override
  void dispose() {
    nome.dispose();
    email.dispose();
    senha.dispose();
    confirmar.dispose();
    super.dispose();
  }

  void cadastrar() {
    if (nome.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        senha.text.isEmpty ||
        confirmar.text.isEmpty) {
      mensagem('Preencha todos os campos!');
      return;
    }

    if (!email.text.contains('@')) {
      mensagem('Digite um e-mail válido!');
      return;
    }

    if (senha.text.length < 6) {
      mensagem('A senha precisa ter pelo menos 6 caracteres!');
      return;
    }

    if (senha.text != confirmar.text) {
      mensagem('As senhas não são iguais!');
      return;
    }

    mensagem('Cadastro realizado com sucesso!');

    widget.onCadastro();
  }

  void mensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto)),
    );
  }

  InputDecoration decoracao(
      String titulo,
      IconData icone,
      ) {
    return InputDecoration(
      hintText: titulo,
      prefixIcon: Icon(icone),
      filled: true,
      fillColor: const Color(0xFFF0EEFF),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF8FF),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 25),

              const Icon(
                Icons.menu_book,
                size: 65,
                color: Color(0xFF4520C9),
              ),

              const SizedBox(height: 12),

              const Text(
                'Faça seu Cadastro',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF242078),
                ),
              ),

              const SizedBox(height: 38),

              // Nome
              TextField(
                controller: nome,
                decoration: decoracao(
                  'Nome completo',
                  Icons.person_outline,
                ),
              ),

              const SizedBox(height: 15),

              // E-mail
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: decoracao(
                  'E-mail',
                  Icons.email_outlined,
                ),
              ),

              const SizedBox(height: 15),

              // Senha
              TextField(
                controller: senha,
                obscureText: ocultarSenha,
                decoration: decoracao(
                  'Senha',
                  Icons.lock_outline,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      ocultarSenha
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        ocultarSenha = !ocultarSenha;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Confirmar senha
              TextField(
                controller: confirmar,
                obscureText: ocultarConfirmacao,
                decoration: decoracao(
                  'Confirmar senha',
                  Icons.lock_outline,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      ocultarConfirmacao
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        ocultarConfirmacao =
                        !ocultarConfirmacao;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // BOTÃO CADASTRAR
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4520C9),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar-se',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // VOLTAR PARA LOGIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Já possui uma conta?',
                    style: TextStyle(color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: widget.onCadastro,
                    child: const Text(
                      'Faça seu login.',
                      style: TextStyle(
                        color: Color(0xFF4520C9),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
