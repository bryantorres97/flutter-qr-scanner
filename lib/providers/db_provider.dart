import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qr_scanner/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    // Path de la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);
    //Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
          ''');
    });
  }

  Future<int> nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toMap());
    return res;
  }

  Future<int> nuevoScanRaw(ScanModel scan) async {
    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO Scans(id, tipo, valor)
    VALUES($id, '$tipo', '$valor')
    ''');
    return res;
  }

  Future<ScanModel?> obtenerScanPorId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  Future<List<ScanModel>> obtenerScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromMap(scan)).toList()
        : [];
  }

  Future<List<ScanModel>> obtenerScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromMap(scan)).toList()
        : [];
  }

  Future<int> actualizarScanPorId(ScanModel nuevoScan) async {
    final db = await database;
    final res = db.update('Scans', nuevoScan.toMap(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> borrarScanPorId(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> borrarScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
