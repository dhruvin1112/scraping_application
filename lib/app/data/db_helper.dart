import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../services/notification_service.dart';

class DbHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), "scrap.db");

    return await openDatabase(
      path,
      version: 6,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          mobile TEXT,
          email TEXT,
          location TEXT,
          password TEXT
        )
        ''');

        await database.execute('''
          CREATE TABLE leads(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER,
          scrapType TEXT,
          quantity TEXT,
          price TEXT,
          description TEXT,
          address TEXT,
          city TEXT,
          pincode TEXT,
          imagePath TEXT,
          createdAt TEXT,
          sellerName TEXT,
          sellerMobile TEXT,
          sellerLocation TEXT
        )
        ''');

        await database.execute('''
          CREATE TABLE lead_views(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          leadId INTEGER,
          sellerId INTEGER,
          buyerId INTEGER,
          buyerName TEXT,
          buyerMobile TEXT,
          viewedAt TEXT
        )
        ''');
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        if (oldVersion < 6) {
          await database.execute('''
            CREATE TABLE IF NOT EXISTS lead_views(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            leadId INTEGER,
            sellerId INTEGER,
            buyerId INTEGER,
            buyerName TEXT,
            buyerMobile TEXT,
            viewedAt TEXT
          )
          ''');
        }
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> data) async {
    final d = await db;
    return await d.insert("users", data);
  }

  Future<Map<String, dynamic>?> loginUser(String mobile, String password) async {
    final d = await db;
    final res = await d.query(
      "users",
      where: "mobile=? AND password=?",
      whereArgs: [mobile, password],
    );
    if (res.isNotEmpty) return Map<String, dynamic>.from(res.first);
    return null;
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final d = await db;
    final res = await d.query("users", where: "id=?", whereArgs: [id]);
    if (res.isNotEmpty) return Map<String, dynamic>.from(res.first);
    return null;
  }

  Future<int> insertLead(Map<String, dynamic> data) async {
    final d = await db;
    final id = await d.insert("leads", data);

    await NotificationService.showNotification(
      title: "Lead Added",
      body: "${data["scrapType"]} lead created",
    );

    return id;
  }

  Future<List<Map<String, dynamic>>> getLeads() async {
    final d = await db;
    final res = await d.query("leads", orderBy: "id DESC");
    return res.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getLeadsByUser(int userId) async {
    final d = await db;
    final res = await d.query(
      "leads",
      where: "userId=?",
      whereArgs: [userId],
      orderBy: "id DESC",
    );
    return res.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<int> insertLeadView(Map<String, dynamic> data) async {
    final d = await db;
    return await d.insert("lead_views", data);
  }

  Future<List<Map<String, dynamic>>> getLeadViewsBySeller(int sellerId) async {
    final d = await db;
    final res = await d.query(
      "lead_views",
      where: "sellerId=?",
      whereArgs: [sellerId],
      orderBy: "id DESC",
    );
    return res.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<int> deleteLead(int id) async {
    final d = await db;
    return await d.delete("leads", where: "id=?", whereArgs: [id]);
  }

  Future<int> updateLead(int id, Map<String, dynamic> data) async {
    final d = await db;
    return await d.update("leads", data, where: "id=?", whereArgs: [id]);
  }

  Future<int> updateProfile(int id, Map<String, dynamic> data) async {
    final d = await db;
    return await d.update(
      "users",
      data,
      where: "id=?",
      whereArgs: [id],
    );
  }
  Future<List<Map<String, dynamic>>> getLeadViewsByLeadId(int leadId) async {
    final d = await db;
    final res = await d.query(
      "lead_views",
      where: "leadId=?",
      whereArgs: [leadId],
      orderBy: "id DESC",
    );
    return res.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<bool> isAlreadyViewed(int leadId, int buyerId) async {
    final db = await this.db;

    final result = await db.query(
      "lead_views",
      where: "leadId = ? AND buyerId = ?",
      whereArgs: [leadId, buyerId],
    );

    return result.isNotEmpty;
  }

  Future<int> getTotalViewsBySeller(int sellerId) async {
    final d = await db;

    final result = await d.rawQuery(
      '''
    SELECT COUNT(*) as total
    FROM lead_views
    WHERE sellerId = ?
    ''',
      [sellerId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }



}
