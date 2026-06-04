import 'package:flutter/material.dart';
import 'package:releae/features/card/cardModel.dart';
import 'package:releae/features/card/cardService.dart';

class CardItem extends StatefulWidget {
  final CardModel card;
  final VoidCallback onDeleted;

  const CardItem({super.key, required this.card, required this.onDeleted});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final CardService cardService = CardService();

  bool isFavorite = false;
  bool isDeleting = false;

  Future<void> deleteCard() async {
    setState(() {
      isDeleting = true;
    });

    try {
      await cardService.deleteCard(widget.card.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card excluido com sucesso'),
          backgroundColor: Colors.green,
        ),
      );

      widget.onDeleted();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao excluir card'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE5E5E5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.card.title,
                    style: const TextStyle(
                      color: Color(0xFF2F2F2F),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: isFavorite
                      ? const Color(0xFFE11D48)
                      : const Color(0xFF888888),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minHeight: 36,
                    minWidth: 36,
                  ),
                  tooltip: isFavorite
                      ? 'Remover dos favoritos'
                      : 'Adicionar aos favoritos',
                ),
                IconButton(
                  onPressed: isDeleting ? null : deleteCard,
                  icon: isDeleting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF888888),
                          ),
                        )
                      : const Icon(Icons.delete_outline),
                  color: const Color(0xFF888888),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minHeight: 36,
                    minWidth: 36,
                  ),
                  tooltip: 'Excluir card',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.card.description,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ID: ${widget.card.id}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF888888), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
