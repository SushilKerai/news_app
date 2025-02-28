import 'package:flutter/material.dart';
import 'package:news_app/categories.dart';
import 'package:news_app/language_list.dart';
import 'package:news_app/latest_news.dart';
import 'package:news_app/region.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of screens corresponding to bottom navigation items
  final List<Widget> _screens = [
    NewsScreen(
      fetchLatestNews: true,
    ),
    const Categories(),
    const Region(),
    const LanguageListScreen(),
  ];

  // Update the selected index
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      darkTheme: ThemeData.dark(), // Dark theme for the app bar
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      initialRoute: '/', // Default route when app starts
      home: Scaffold(
        body: _screens[_currentIndex], // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed, // Fixes all items on the bar
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Latest News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Region',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: 'Languages',
            ),
          ],
          selectedItemColor: Colors.blue, // Highlighted item color
          unselectedItemColor: Colors.grey, // Non-highlighted items
        ),
      ),
    );
  }

  // AppBar titles for each tab
}
