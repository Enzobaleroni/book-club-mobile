import 'package:flutter/material.dart';

class CodigoPage extends StatefulWidget {
  final String email;

  const CodigoPage({
    super.key,
    required this.email,
  });

  @override
  State<CodigoPage> createState() => _CodigoPageState();
}

class _CodigoPageState extends State<CodigoPage> {
  final codigo = TextEditingController();

  @override
  void dispose() {
    codigo.dispose();
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
                  'Digite o código',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242078),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Enviamos um código para ${widget.email}',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: codigo,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: 'Código',
                    filled: true,
                    fillColor: Color(0xFFF0EEFF),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (codigo.text.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Digite os 6 números do código!'),
                          ),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Tela de redefinição de senha ainda não conectada.',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4520C9),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Confirmar ✓'),
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