import 'package:flutter/material.dart';
import 'package:bookclubmobile/paginaInicial.dart';

class Telacadastro extends StatefulWidget {
  const Telacadastro({super.key});

  @override
  State<Telacadastro> createState() => _TelacadastroState();
}

class _TelacadastroState extends State<Telacadastro> {
  bool lembrarMe = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),

      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo_book2.png',
                  width: 120,
                  height: 120,
                  ),
                  const SizedBox(height: 10),
                  
                  const Text("Faça seu Cadastro",
                    style: TextStyle(fontSize: 34,
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

                  TextField(
                    keyboardType: TextInputType.name,

                    decoration: InputDecoration(
                      hintText: "nome e sobrenome",

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

                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "nome e sobrenome",

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
                ],
              ),
              ),
            ),
          ),
      ),

    );
  }
}

