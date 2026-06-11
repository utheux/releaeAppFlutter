import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releae/widgets/cardForm.dart';
import 'package:releae/widgets/navBar.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Relêaê",
              style: GoogleFonts.poppins(
                color: Color(0xFF2F2F2F),
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Text(
              "Adicione Cards para serem revisados",
              maxLines: 2,
              style: GoogleFonts.poppins(
                color: Color(0xFF888888),
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                "https://img.magnific.com/fotos-gratis/jovem-bonito-vestindo-camiseta-casual-sobre-o-rosto-feliz-de-fundo-azul-sorrindo-com-os-bracos-cruzados-olhando-para-a-camera-pessoa-positiva_839833-12963.jpg?semt=ais_hybrid&w=740&q=80",
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: CardForm(),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
