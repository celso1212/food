import 'package:flutter/material.dart';
import 'package:food/views/cart_page.dart';
import 'package:food/views/favorites_page.dart';
import 'package:food/views/feedback_page.dart';
import 'package:food/views/home_page.dart';
import 'package:food/views/profile_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndexPage = 0;
  List pages = [
    HomePage(),
    FavoritesPage(),
    FeedbackPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndexPage],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_outlined),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int newIndex) {
          setState(() {
            currentIndexPage = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.red),
        currentIndex: currentIndexPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: 'Feedback'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Usuário'),
        ],
      ),
    );
  }
}
