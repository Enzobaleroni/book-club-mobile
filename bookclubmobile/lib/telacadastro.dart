import 'package:flutter/gestures.dart';
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
                  const SizedBox(height: 20),

                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,

                    decoration: InputDecoration(
                      hintText: "Confirmar Senha",

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
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaInicial()));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Cadastre-se realizado"),
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
                        "Cadastre-se",

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

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
                            text: "Já tem uma conta? ",
                          ),

                          TextSpan(
                            text: "Faça seu Login",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const PaginaInicial(),
                                    )
                                );































                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Faça seu Login"),
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