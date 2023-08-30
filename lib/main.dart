import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:newsreel/pages/homepage.dart';
import 'package:newsreel/pages/searchpage.dart';
import 'package:newsreel/pages/settingspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsReel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var currPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currPage) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = SearchPage();
        break;
      case 2:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $currPage');
    }

    return Scaffold(
      // NavBar Video: https://www.youtube.com/watch?v=FEvYl8Mzsxw
      bottomNavigationBar: GNav(
        onTabChange: (index) {
          setState(() {
            currPage = index;
          });
        },
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
      body: Center(
        child: page,
      ),
    );
  }
}
