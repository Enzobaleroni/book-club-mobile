
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/livro.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  static const int usuarioId = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('book_club.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final caminho = join(await getDatabasesPath(), fileName);

    return await openDatabase(
      caminho,
      version: 4,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _criarBanco,
      onUpgrade: _atualizarBanco,
    );
  }

  Future<void> _criarBanco(Database db, int version) async {
    await db.execute('''
      CREATE TABLE livros (
        id INTEGER PRIMARY KEY,
        titulo TEXT NOT NULL,
        autor TEXT NOT NULL,
        categoria TEXT,
        preco TEXT NOT NULL,
        preco_antigo TEXT,
        descricao TEXT,
        imagem TEXT,
        avaliacao REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha_hash TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE carrinho (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        livro_id INTEGER NOT NULL,
        quantidade INTEGER NOT NULL DEFAULT 1,
        UNIQUE(usuario_id, livro_id),
        FOREIGN KEY (livro_id) REFERENCES livros(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        total REAL NOT NULL,
        status TEXT NOT NULL,
        metodo_pagamento TEXT,
        criado_em TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE itens_pedido (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pedido_id INTEGER NOT NULL,
        livro_id INTEGER NOT NULL,
        titulo TEXT NOT NULL,
        preco REAL NOT NULL,
        quantidade INTEGER NOT NULL,
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
      )
    ''');

    await _inserirLivrosIniciais(db);
  }

  Future<void> _atualizarBanco(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE livros ADD COLUMN categoria TEXT',
      );
    }

    if (oldVersion < 3) {
      await _inserirLivrosIniciais(db);
    }

    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE usuarios (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          senha_hash TEXT NOT NULL
        )
      ''');
    }
  }

  Future<void> _inserirLivrosIniciais(Database db) async {
    final livrosIniciais = [
      {
        'id': 1,
        'titulo': 'Como Convencer Alguém em 90 Segundos',
        'autor': 'Nicholas Boothman',
        'categoria': 'Negócios',
        'preco': '33,17',
        'preco_antigo': '39,90',
        'descricao': 'Aprenda técnicas para causar boas primeiras impressões e melhorar sua comunicação.',
        'imagem': 'assets/livro1.jpg',
        'avaliacao': 4.8,
      },
      {
        'id': 2,
        'titulo': 'As Armas da Persuasão',
        'autor': 'Robert B. Cialdini',
        'categoria': 'Psicologia',
        'preco': '87,33',
        'preco_antigo': '99,90',
        'descricao': 'Conheça os princípios da persuasão e como eles aparecem nas decisões do dia a dia.',
        'imagem': 'assets/livro2.jpg',
        'avaliacao': 4.9,
      },
      {
        'id': 3,
        'titulo': 'Gatilhos Mentais',
        'autor': 'Gustavo Ferreira',
        'categoria': 'Marketing',
        'preco': '60,70',
        'preco_antigo': '75,90',
        'descricao': 'Um livro sobre comunicação, marketing e comportamento de compra.',
        'imagem': 'assets/livro3.jpg',
        'avaliacao': 4.8,
      },
      {
        'id': 4,
        'titulo': 'A Máquina Definitiva de Vendas',
        'autor': 'Chet Holmes',
        'categoria': 'Vendas',
        'preco': '280,00',
        'preco_antigo': '320,00',
        'descricao': 'Estratégias para organizar processos comerciais e desenvolver equipes de vendas.',
        'imagem': 'assets/livro4.jpg',
        'avaliacao': 4.7,
      },
      {
        'id': 5,
        'titulo': 'A Arte da Guerra',
        'autor': 'Sun Tzu',
        'categoria': 'Estratégia',
        'preco': '45,90',
        'preco_antigo': '59,90',
        'descricao': 'Uma obra clássica sobre estratégia, planejamento e tomada de decisões.',
        'imagem': 'assets/livro5.jpg',
        'avaliacao': 4.9,
      },
      {
        'id': 6,
        'titulo': 'O Poder do Hábito',
        'autor': 'Charles Duhigg',
        'categoria': 'Autoconhecimento',
        'preco': '44,90',
        'preco_antigo': '59,90',
        'descricao': 'Entenda como os hábitos funcionam e como podem ser transformados.',
        'imagem': 'assets/livro6.jpg',
        'avaliacao': 4.8,
      },
      {
        'id': 7,
        'titulo': 'Mindset',
        'autor': 'Carol S. Dweck',
        'categoria': 'Desenvolvimento',
        'preco': '39,90',
        'preco_antigo': '49,90',
        'descricao': 'Conheça a ideia de mentalidade fixa e mentalidade de crescimento.',
        'imagem': 'assets/livro7.jpg',
        'avaliacao': 4.8,
      },
      {
        'id': 8,
        'titulo': 'Os 7 Hábitos das Pessoas Altamente Eficazes',
        'autor': 'Stephen R. Covey',
        'categoria': 'Produtividade',
        'preco': '55,00',
        'preco_antigo': '69,90',
        'descricao': 'Princípios para desenvolver hábitos de organização, produtividade e liderança.',
        'imagem': 'assets/livro8.jpg',
        'avaliacao': 4.9,
      },
    ];

    final batch = db.batch();

    for (final livro in livrosIniciais) {
      batch.insert(
        'livros',
        livro,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // ==========================================
  // USUÁRIOS
  // ==========================================

  String _gerarHash(String senha) {
    return sha256.convert(utf8.encode(senha)).toString();
  }

  Future<int> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final db = await database;

    return await db.insert(
      'usuarios',
      {
        'nome': nome.trim(),
        'email': email.trim().toLowerCase(),
        'senha_hash': _gerarHash(senha),
      },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<bool> autenticarUsuario(
      String email,
      String senha,
      ) async {
    final db = await database;

    final resultado = await db.query(
      'usuarios',
      columns: ['id'],
      where: 'email = ? AND senha_hash = ?',
      whereArgs: [
        email.trim().toLowerCase(),
        _gerarHash(senha),
      ],
      limit: 1,
    );

    return resultado.isNotEmpty;
  }

  Future<bool> emailExiste(String email) async {
    final db = await database;

    final resultado = await db.query(
      'usuarios',
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email.trim().toLowerCase()],
      limit: 1,
    );

    return resultado.isNotEmpty;
  }

  // ==========================================
  // LIVROS
  // ==========================================

  Future<List<Livro>> listarLivros() async {
    final db = await database;

    final resultado = await db.query(
      'livros',
      orderBy: 'id ASC',
    );

    return resultado.map((map) => Livro.fromMap(map)).toList();
  }

  Future<Livro?> buscarLivro(int id) async {
    final db = await database;

    final resultado = await db.query(
      'livros',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return null;

    return Livro.fromMap(resultado.first);
  }

  // ==========================================
  // CARRINHO
  // ==========================================

  Future<void> adicionarCarrinho(
      int livroId, {
        int usuarioId = DatabaseHelper.usuarioId,
      }) async {
    final db = await database;

    await db.rawInsert(
      '''
      INSERT INTO carrinho (usuario_id, livro_id, quantidade)
      VALUES (?, ?, 1)
      ON CONFLICT(usuario_id, livro_id)
      DO UPDATE SET quantidade = quantidade + 1
      ''',
      [usuarioId, livroId],
    );
  }

  Future<List<Livro>> listarCarrinho({
    int usuarioId = DatabaseHelper.usuarioId,
  }) async {
    final db = await database;

    final resultado = await db.rawQuery(
      '''
      SELECT livros.*, carrinho.quantidade
      FROM carrinho
      INNER JOIN livros ON livros.id = carrinho.livro_id
      WHERE carrinho.usuario_id = ?
      ORDER BY carrinho.id DESC
      ''',
      [usuarioId],
    );

    final List<Livro> lista = [];

    for (final item in resultado) {
      final livro = Livro.fromMap(item);
      final quantidade = item['quantidade'] as int;

      for (int i = 0; i < quantidade; i++) {
        lista.add(livro);
      }
    }

    return lista;
  }

  Future<void> excluirCarrinho(
      int livroId, {
        int usuarioId = DatabaseHelper.usuarioId,
      }) async {
    final db = await database;

    await db.delete(
      'carrinho',
      where: 'usuario_id = ? AND livro_id = ?',
      whereArgs: [usuarioId, livroId],
    );
  }

  Future<void> alterarQuantidade(
      int livroId,
      int quantidade, {
        int usuarioId = DatabaseHelper.usuarioId,
      }) async {
    final db = await database;

    if (quantidade <= 0) {
      await excluirCarrinho(
        livroId,
        usuarioId: usuarioId,
      );
      return;
    }

    await db.update(
      'carrinho',
      {'quantidade': quantidade},
      where: 'usuario_id = ? AND livro_id = ?',
      whereArgs: [usuarioId, livroId],
    );
  }

  // ==========================================
  // PEDIDOS
  // ==========================================

  Future<int> criarPedido({
    required String metodoPagamento,
    int usuarioId = DatabaseHelper.usuarioId,
  }) async {
    final db = await database;

    return await db.transaction((txn) async {
      final itens = await txn.rawQuery(
        '''
        SELECT livros.*, carrinho.quantidade
        FROM carrinho
        INNER JOIN livros ON livros.id = carrinho.livro_id
        WHERE carrinho.usuario_id = ?
        ''',
        [usuarioId],
      );

      if (itens.isEmpty) {
        throw Exception('O carrinho está vazio.');
      }

      double total = 0;

      for (final item in itens) {
        final preco = double.tryParse(
          item['preco']
              .toString()
              .replaceAll('.', '')
              .replaceAll(',', '.'),
        ) ?? 0;

        total += preco * (item['quantidade'] as int);
      }

      final pedidoId = await txn.insert('pedidos', {
        'usuario_id': usuarioId,
        'total': total,
        'status': 'Aguardando pagamento',
        'metodo_pagamento': metodoPagamento,
        'criado_em': DateTime.now().toIso8601String(),
      });

      for (final item in itens) {
        final preco = double.tryParse(
          item['preco']
              .toString()
              .replaceAll('.', '')
              .replaceAll(',', '.'),
        ) ?? 0;

        await txn.insert('itens_pedido', {
          'pedido_id': pedidoId,
          'livro_id': item['id'],
          'titulo': item['titulo'],
          'preco': preco,
          'quantidade': item['quantidade'],
        });
      }

      await txn.delete(
        'carrinho',
        where: 'usuario_id = ?',
        whereArgs: [usuarioId],
      );

      return pedidoId;
    });
  }

  Future<List<Map<String, dynamic>>> listarPedidos({
    int usuarioId = DatabaseHelper.usuarioId,
  }) async {
    final db = await database;

    return await db.query(
      'pedidos',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'criado_em DESC',
    );
  }

  Future<List<Map<String, dynamic>>> listarItensPedido(
      int pedidoId,
      ) async {
    final db = await database;

    return await db.query(
      'itens_pedido',
      where: 'pedido_id = ?',
      whereArgs: [pedidoId],
    );
  }

  Future<void> atualizarStatusPedido(
      int pedidoId,
      String status,
      ) async {
    final db = await database;

    await db.update(
      'pedidos',
      {'status': status},
      where: 'id = ?',
      whereArgs: [pedidoId],
    );
  }

  Future<void> fecharBanco() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
