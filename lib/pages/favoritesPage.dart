import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releae/features/favorite/favoriteModel.dart';
import 'package:releae/features/favorite/favoriteRepository.dart';
import 'package:releae/widgets/cardItem.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<FavoriteModel>> favoritesFuture;

  final FavoriteRepository favoriteRepository = FavoriteRepository();

  @override
  void initState() {
    super.initState();
    favoritesFuture = favoriteRepository.findAll();
  }

  void refreshFavorites() {
    setState(() {
      favoritesFuture = favoriteRepository.findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        title: Text(
          'Favoritos',
          style: GoogleFonts.poppins(
            color: const Color(0xFF2F2F2F),
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2F2F2F)),
      ),
      body: FutureBuilder<List<FavoriteModel>>(
        future: favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2F2F2F)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Erro ao carregar favoritos: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum card favoritado.',
                style: TextStyle(color: Color(0xFF2F2F2F), fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return CardItem(
                card: favorites[index].toCardModel(),
                onDeleted: refreshFavorites,
                onFavoriteChanged: refreshFavorites,
                showDeleteButton: false,
              );
            },
          );
        },
      ),
    );
  }
}
