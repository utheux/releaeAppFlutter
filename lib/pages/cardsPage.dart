import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releae/features/card/cardModel.dart';
import 'package:releae/features/card/cardService.dart';
import 'package:releae/widgets/cardItem.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  late Future<List<CardModel>> cardsFuture;

  final CardService cardService = CardService();

  @override
  void initState() {
    super.initState();
    cardsFuture = cardService.findAll();
  }

  void refreshCards() {
    setState(() {
      cardsFuture = cardService.findAll();
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
          'Meus cards',
          style: GoogleFonts.poppins(
            color: const Color(0xFF2F2F2F),
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2F2F2F)),
      ),
      body: FutureBuilder<List<CardModel>>(
        future: cardsFuture,
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
                  'Erro ao carregar cards: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          final cards = snapshot.data ?? [];

          if (cards.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum card encontrado.',
                style: TextStyle(color: Color(0xFF2F2F2F), fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];

              return CardItem(card: card, onDeleted: refreshCards);
            },
          );
        },
      ),
    );
  }
}
