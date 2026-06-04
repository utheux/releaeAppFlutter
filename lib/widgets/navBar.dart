import 'package:flutter/material.dart';
import 'package:releae/pages/cardsPage.dart';
import 'package:releae/pages/newsPage.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsPage()),
            );
          },
          icon: Icon(Icons.article_outlined),
          iconSize: 35,
          splashRadius: 24,
          color: Color(0xFF2F2F2F),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CardsPage()),
            );
          },
          icon: Icon(Icons.view_list_outlined),
          iconSize: 35,
          splashRadius: 24,
          color: Color(0xFF2F2F2F),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_box_outlined),
          iconSize: 35,
          splashRadius: 24,
          color: Color(0xFF2F2F2F),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_outline),
          iconSize: 35,
          splashRadius: 24,
          color: Color(0xFF2F2F2F),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.rate_review_outlined),
          iconSize: 35,
          splashRadius: 24,
          color: Color(0xFF2F2F2F),
        ),
      ],
    );
  }
}
