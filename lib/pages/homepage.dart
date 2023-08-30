import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:newsreel/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // NavBar Video: https://www.youtube.com/watch?v=FEvYl8Mzsxw
      bottomNavigationBar: GNav(
        tabs: [
          GButton(
            icon: Icons.home,
          ),
          GButton(
            icon: Icons.search,
          ),
          GButton(
            icon: Icons.settings,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NewsReel',
            ),
          ],
        ),
      ),
    );
  }
}
