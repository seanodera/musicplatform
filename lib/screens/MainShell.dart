import 'package:flutter/material.dart';
import 'package:musicplatform/screens/Library.dart';
import 'package:musicplatform/screens/Search.dart';

import 'Home.dart';

class MainShell extends StatefulWidget {
  const MainShell({Key? key}) : super(key: key);

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int index;
  @override
  void initState() {
    index = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const SearchScreen(),
        const Library(),
      ].elementAt(index),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        BottomNavigationBarItem(icon: Icon(Icons.my_library_music_outlined), label: 'library'),
      ], onTap: (_index){
        setState(() {
          index =_index;
        });
      },selectedItemColor: Colors.redAccent.shade400,),
    );
  }
}
