// ============================================================
// ARQUIVO: lib/tema.dart  (TEMA + WIDGETS COMPARTILHADOS)
// ============================================================
import 'package:flutter/material.dart';

class Cores {
  static const Color roxo = Color(0xFF4B1EFF);
  static const Color roxoEscuro = Color(0xFF2E1AA8);
  static const Color roxoClaro = Color(0xFFEDEAFF);
  static const Color rosa = Color(0xFFE91E8C);
  static const Color fundo = Color(0xFFFAFAFF);
  static const Color borda = Color(0xFFD9D4FF);
  static const Color textoSecundario = Color(0xFF6B6B76);
}

ThemeData criarTema() {
  final esquema = ColorScheme.fromSeed(
    seedColor: Cores.roxo,
    primary: Cores.roxo,
  );

  OutlineInputBorder borda(Color cor, [double largura = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cor, width: largura),
    );
  }

  return ThemeData(
    useMaterial3: true,
    colorScheme: esquema,
    scaffoldBackgroundColor: Cores.fundo,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
      border: borda(Cores.borda),
      enabledBorder: borda(Cores.borda),
      focusedBorder: borda(Cores.roxo, 2),
      errorBorder: borda(Colors.red.shade400),
      focusedErrorBorder: borda(Colors.red.shade400, 2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Cores.roxo,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Cores.roxo,
        minimumSize: const Size.fromHeight(50),
        side: const BorderSide(color: Cores.roxo),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Cores.roxo,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: Cores.roxoClaro,
    ),
  );
}

void mostrarMensagem(BuildContext context, String texto) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(texto),
        behavior: SnackBarBehavior.floating,
      ),
    );
}

class Validadores {
  static String? obrigatorio(String? v) {
    if (v == null || v.trim().isEmpty) return 'Preencha este campo';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Informe seu e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }

  static String? senhaNova(String? v) {
    if (v == null || v.isEmpty) return 'Crie uma senha';
    if (v.length < 8) return 'Mínimo de 8 caracteres';
    return null;
  }
}

class LogoBook extends StatelessWidget {
  final double tamanho;
  const LogoBook({super.key, this.tamanho = 72});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo_book2.png',
      width: tamanho,
      height: tamanho,
      errorBuilder: (context, error, stack) => Container(
        width: tamanho,
        height: tamanho,
        decoration: BoxDecoration(
          color: Cores.roxo,
          borderRadius: BorderRadius.circular(tamanho * 0.3),
        ),
        child: Icon(Icons.menu_book, color: Colors.white, size: tamanho * 0.55),
      ),
    );
  }
}

class CampoTexto extends StatefulWidget {
  final String rotulo;
  final String dica;
  final TextEditingController? controller;
  final bool senha;
  final TextInputType? teclado;
  final TextInputAction acao;
  final String? Function(String?)? validador;
  final ValueChanged<String>? aoMudar;
  final Iterable<String>? autofill;

  const CampoTexto({
    super.key,
    required this.rotulo,
    required this.dica,
    this.controller,
    this.senha = false,
    this.teclado,
    this.acao = TextInputAction.next,
    this.validador,
    this.aoMudar,
    this.autofill,
  });

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  bool _oculto = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.rotulo,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Cores.roxoEscuro,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.senha && _oculto,
          keyboardType: widget.teclado,
          textInputAction: widget.acao,
          validator: widget.validador,
          onChanged: widget.aoMudar,
          autofillHints: widget.autofill,
          decoration: InputDecoration(
            hintText: widget.dica,
            suffixIcon: widget.senha
                ? IconButton(
              tooltip: _oculto ? 'Mostrar senha' : 'Ocultar senha',
              icon: Icon(
                _oculto
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () => setState(() => _oculto = !_oculto),
            )
                : null,
          ),
        ),
      ],
    );
  }
}
