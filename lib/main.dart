import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/blocs/categories_bloc/categories_bloc.dart';
import 'package:test_task/blocs/dishes_bloc/dish_bloc.dart';
import 'package:test_task/pages/BucketPage.dart';
import 'package:test_task/pages/CategoryPage.dart';

import 'pages/MainPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          
        ),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  int _selectedIndex = 0;
  String _selectedCategory = '';
  PageController _pageController = PageController();
//Лучше конечно использовать TextTheme
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            if (value < 4) {
              setState(() {
                _selectedIndex = value;
              });
            }
          },
          controller: _pageController,
          children: [
            MainPage(onTapCategory: (v) {_pageController.jumpToPage(4);
              setState(() {
                _selectedCategory = v;
              });
            }),
            _searchPage(),
            BucketPage(),
            _profile(),
            CategoryPage(category: _selectedCategory, goBackTap: () {_pageController.jumpToPage(0);})
            // _categoryPage(_selectedCategory, () {_pageController.jumpToPage(0);})
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Главная', tooltip: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск', tooltip: 'Поиск'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Корзина', tooltip: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Аккаунт', tooltip: 'Аккаунт'),
        ], 
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 11, fontWeight: FontWeight.w500
        ),
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _selectedIndex = index;
          });
        },
      )
    );
  }

  Widget _searchPage() {
    return Expanded(child: Placeholder());
  }

  Widget _profile() {
    return Expanded(child: Placeholder());
  }

}
