import 'package:releae/database/appDatabase.dart';
import 'package:releae/features/card/cardModel.dart';
import 'package:releae/features/favorite/favoriteModel.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRepository {
  final AppDatabase appDatabase;

  FavoriteRepository({AppDatabase? appDatabase})
    : appDatabase = appDatabase ?? AppDatabase.instance;

  Future<void> add(CardModel card) async {
    final db = await appDatabase.database;
    final favorite = FavoriteModel.fromCard(card);

    await db.insert(
      'favorites',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> remove(String id) async {
    final db = await appDatabase.database;

    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    final db = await appDatabase.database;

    final result = await db.query(
      'favorites',
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<List<FavoriteModel>> findAll() async {
    final db = await appDatabase.database;

    final result = await db.query('favorites', orderBy: 'favorited_at DESC');

    return result.map(FavoriteModel.fromMap).toList();
  }
}
