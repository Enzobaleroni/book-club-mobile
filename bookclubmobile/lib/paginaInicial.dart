import 'package:bookclubmobile/telacadastro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {

  bool lembrarMe = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  // LOGO
                  Image.asset(
                    "assets/logo_book2.png",
                    width: 120,
                    height: 120,
                  ),

                  const SizedBox(height: 10),

                  // TITULO
                  const Text(
                    "Faça seu login",

                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E1AA8),

                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // CAMPO EMAIL
                  TextField(
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      hintText: "E-mail",

                      filled: true,
                      fillColor: Colors.white,

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),

                        borderSide: const BorderSide(
                          color: Color(0xFFB4A9FF),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),

                        borderSide: const BorderSide(
                          color: Color(0xFF4B1EFF),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CAMPO SENHA
                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,

                    decoration: InputDecoration(
                      hintText: "Senha",

                      filled: true,
                      fillColor: Colors.white,

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),

                        borderSide: const BorderSide(
                          color: Color(0xFFB4A9FF),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),

                        borderSide: const BorderSide(
                          color: Color(0xFF4B1EFF),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // CHECKBOX
                  Row(
                    children: [

                      Checkbox(
                        value: lembrarMe,

                        onChanged: (value) {
                          setState(() {
                            lembrarMe = value!;
                          });
                        },
                      ),

                      const Text(
                        "Lembrar de mim",

                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // BOTÃO LOGIN
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login realizado"),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B1EFF),
                        elevation: 5,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),

                      child: const Text(
                        "Login",

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // BOTÃO GOOGLE
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton.icon(
                      onPressed: () {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Entrando com Google"),
                          ),
                        );
                      },

                      icon: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                        width: 24,
                        height: 24,
                      ),

                      label: const Text(
                        "Entrar com Google",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B1EFF),
                        elevation: 5,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // TEXTO FINAL COM LINKS
                  Align(
                    alignment: Alignment.centerLeft,

                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),

                        children: [

                          const TextSpan(
                            text: "Não tem uma conta? ",
                          ),

                          TextSpan(
                            text: "Cadastre-se",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Telacadastro(),
                              )
                              );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Abrir cadastro"),
                                  ),
                                );
                              },
                          ),

                          const TextSpan(
                            text: " ou ",
                          ),

                          TextSpan(
                            text: "Recuperar senha",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Recuperar senha"),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}