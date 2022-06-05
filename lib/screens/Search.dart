import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          width: size.width,
          child: TextField(
              autocorrect: false,
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  label: Text('Search here'),
                  hintText: 'Search here'),
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              }),
        ),
      ],
    );
  }
}

class Browse extends StatelessWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchResults extends StatelessWidget {
  final String searchTerm;
  const SearchResults({Key? key, required this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [],
              )
            ],
          ),
        )
      ],
    );
  }
}
