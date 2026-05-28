import 'package:flutter/material.dart';

class Homepagi extends StatefulWidget {
  const Homepagi({super.key});

  @override
  State<Homepagi> createState() => _HomepagiState();
}

class _HomepagiState extends State<Homepagi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),

      body: SafeArea(
        child: Center(
          child: Container(
            width: 500,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),

            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),

              image: const DecorationImage(
                image: AssetImage('assets/logo_book2.png'),
                alignment: Alignment.centerLeft,
                scale: 7,
                fit: BoxFit.none,
              ),
            ),

            child: const Row(
              children: [
                SizedBox(width: 70),

                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      border: InputBorder.none,

                      // ÍCONE DE LUPA
                      prefixIcon: Icon(Icons.search),
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