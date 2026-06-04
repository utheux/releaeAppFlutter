import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releae/features/card/cardService.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final cardService = CardService();

  bool isLoading = false;

  Future<void> createCard() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o titulo e a descricao'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await cardService.createCard(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );

      if (!mounted) return;

      titleController.clear();
      descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card criado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao criar card'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Crie seu card:",
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2F2F2F),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Digite o título do Card...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
            child: TextFormField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Descrição..",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : createCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2F2F2F),
                  foregroundColor: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text("Salvar Card"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
