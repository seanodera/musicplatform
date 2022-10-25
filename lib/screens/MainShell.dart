import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:musicplatform/components/MiniPlayer.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:musicplatform/screens/Library.dart';
import 'package:musicplatform/screens/Search.dart';
import 'package:provider/provider.dart';

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
    ProviderModel providerModel = Provider.of<ProviderModel>(context);
    TextStyle style = const TextStyle(color: Colors.white);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: [
          const HomeScreen(),
          const SearchScreen(),
          const Library(),
        ].elementAt(index),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 4),
        color: Theme.of(context).colorScheme.background,
        child: BubbleBottomBar(
          currentIndex: index,
          backgroundColor: Theme.of(context).colorScheme.background,
          onTap: (_index) {
            setState(() {
              index = (_index != null) ? _index : 0;
            });
          },
          items: [
            BubbleBottomBarItem(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  'Home',
                  style: style,
                )),
            BubbleBottomBarItem(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                icon: const Icon(Icons.search),
                activeIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                title: Text(
                  'search',
                  style: style,
                )),
            BubbleBottomBarItem(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                icon: const Icon(Icons.my_library_music_outlined),
                activeIcon: const Icon(
                  Icons.my_library_music_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'library',
                  style: style,
                )),
          ],
          opacity: 1,
          iconSize: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<ProviderModel>(
          builder: (context, providerModel, widget) =>
              MiniPlayer(providerModel: providerModel)),
    );
  }
}
