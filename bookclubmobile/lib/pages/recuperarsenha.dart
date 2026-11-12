import 'package:flutter/material.dart';

class RecuperarPage extends StatefulWidget {
  final Function(String) onEnviar;

  const RecuperarPage({
    super.key,
    required this.onEnviar,
  });

  @override
  State<RecuperarPage> createState() => _RecuperarPageState();
}

class _RecuperarPageState extends State<RecuperarPage> {
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const Icon(Icons.menu_book,
                    size: 65, color: Color(0xFF4520C9)),
                const SizedBox(height: 15),
                const Text(
                  'Recuperação de senha',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242078),
                  ),
                ),
                const SizedBox(height: 35),

                const Text(
                  'Digite seu e-mail para receber o código de recuperação.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                    filled: true,
                    fillColor: Color(0xFFF0EEFF),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!email.text.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Digite um e-mail válido!'),
                          ),
                        );
                        return;
                      }

                      widget.onEnviar(email.text);
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Enviar código'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4520C9),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}