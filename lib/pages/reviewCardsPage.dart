import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releae/features/card/cardModel.dart';
import 'package:releae/features/card/cardService.dart';
import 'package:releae/widgets/cardItem.dart';

class ReviewCardsPage extends StatefulWidget {
  const ReviewCardsPage({super.key});

  @override
  State<ReviewCardsPage> createState() => _ReviewCardsPageState();
}

class _ReviewCardsPageState extends State<ReviewCardsPage> {
  late Future<List<CardModel>> cardsFuture;

  final CardService cardService = CardService();

  @override
  void initState() {
    super.initState();
    cardsFuture = cardService.findReviewCards();
  }

  void refreshCards() {
    setState(() {
      cardsFuture = cardService.findReviewCards();
    });
  }

  Future<void> openReviewModal(CardModel card) async {
    final reviewed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _ReviewCardDialog(card: card, cardService: cardService);
      },
    );

    if (reviewed == true) {
      refreshCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        title: Text(
          'Revisar cards',
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
                  'Erro ao carregar cards para revisao: ${snapshot.error}',
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
                'Nenhum card para revisar agora.',
                style: TextStyle(color: Color(0xFF2F2F2F), fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];

              return GestureDetector(
                onTap: () => openReviewModal(card),
                child: CardItem(
                  card: card,
                  onDeleted: refreshCards,
                  showDeleteButton: false,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ReviewCardDialog extends StatefulWidget {
  final CardModel card;
  final CardService cardService;

  const _ReviewCardDialog({required this.card, required this.cardService});

  @override
  State<_ReviewCardDialog> createState() => _ReviewCardDialogState();
}

class _ReviewCardDialogState extends State<_ReviewCardDialog> {
  bool didReview = false;
  bool isReviewing = true;
  String? reviewError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => reviewCard());
  }

  Future<void> reviewCard() async {
    setState(() {
      isReviewing = true;
      reviewError = null;
    });

    try {
      await widget.cardService.reviewCard(widget.card.id);

      if (!mounted) return;

      setState(() {
        didReview = true;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        reviewError = 'Erro ao revisar card: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          isReviewing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        widget.card.title,
        style: const TextStyle(
          color: Color(0xFF2F2F2F),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.card.description,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            _ReviewStatus(
              didReview: didReview,
              isReviewing: isReviewing,
              reviewError: reviewError,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isReviewing
              ? null
              : () => Navigator.pop(context, didReview),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}

class _ReviewStatus extends StatelessWidget {
  final bool didReview;
  final bool isReviewing;
  final String? reviewError;

  const _ReviewStatus({
    required this.didReview,
    required this.isReviewing,
    required this.reviewError,
  });

  @override
  Widget build(BuildContext context) {
    if (isReviewing) {
      return const Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF2F2F2F),
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Registrando revisao...',
            style: TextStyle(color: Color(0xFF666666), fontSize: 14),
          ),
        ],
      );
    }

    if (reviewError != null) {
      return Text(
        reviewError!,
        style: const TextStyle(color: Colors.redAccent, fontSize: 14),
      );
    }

    if (didReview) {
      return const Text(
        'Revisao registrada com sucesso.',
        style: TextStyle(color: Colors.green, fontSize: 14),
      );
    }

    return const SizedBox.shrink();
  }
}
