import 'package:epharmacyapp/pages/cartpage.dart';
import 'package:epharmacyapp/pages/favouritepage.dart';
import 'package:epharmacyapp/pages/mainpage.dart';
import 'package:epharmacyapp/pages/profilepage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = [
    MainPage(),
    FavouritePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.teal,
                  size: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.teal,
                  size: 30,
                ),
                label: 'Favourite'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.teal,
                  size: 30,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.teal,
                  size: 30,
                ),
                label: 'Profile'),
          ]),
      body: pages[selectedIndex],
    );
  }
}
