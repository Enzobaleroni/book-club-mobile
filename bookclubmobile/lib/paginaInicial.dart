import 'package:flutter/material.dart';

class Paginainicial extends StatefulWidget {
  const Paginainicial({super.key});

  @override
  State<Paginainicial> createState() => _PaginainicialState();
}

class _PaginainicialState extends State<Paginainicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // De onde o degradê começa
            end: Alignment.bottomCenter, // Para onde ele vai
            colors: [
              Colors.deepPurpleAccent, // Cor do topo
              Colors.indigo, // Cor de baixo
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.indigoAccent,
                width: 5.0,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset("assets/logo_book2.png"),
                  Text("",)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}