import 'package:flutter/material.dart';
import 'package:musicplatform/components/HomeWidgets.dart';
import 'package:musicplatform/components/LoadingWidgets.dart';
import 'package:musicplatform/podo/HomeModel.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/TempData.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeModel homeModel = Provider.of<HomeModel>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          width: size.width,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
                autocorrect: false,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search here',
                    iconColor: Theme.of(context).colorScheme.secondary,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    focusColor: Theme.of(context).colorScheme.secondary,
                    hoverColor: Theme.of(context).colorScheme.secondary,
                    prefixIconColor: Theme.of(context).colorScheme.secondary,
                    suffixIconColor: Theme.of(context).colorScheme.secondary,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary)),
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                }),
          ),
        ),
        (searchTerm == '')
            ? (homeModel.genres.isEmpty)
                ? LoadingScreen(color: Colors.redAccent.shade400)
                : Browse(
                    homeModel: homeModel,
                  )
            : SearchProcessor(searchTerm: searchTerm),
      ],
    );
  }
}

class Browse extends StatelessWidget {
  final HomeModel homeModel;
  const Browse({Key? key, required this.homeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Genre> genres = homeModel.genres;
    List<int> followedGenres = [];
    return ListView(
      shrinkWrap: true,
      children: [
        const HomeTitle(
          title: 'Your followed Genres',
          showRight: false,
        ),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio:
                    (MediaQuery.of(context).size.width / 2 - 30) / 100),
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Genre genre = genres[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Material(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    color: genre.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(genre.name),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(genre.image)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 10,
        ),
        const HomeTitle(title: 'View All'),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio:
                    (MediaQuery.of(context).size.width / 2 - 30) / 100),
            itemCount: genres.length - 4,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Genre genre = genres[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Material(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: MediaQuery.of(context).size.width / 2 - 6,
                    color: genre.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(genre.name),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(genre.image)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
      ],
    );
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
            children: [],
          ),
        )
      ],
    );
  }
}

class SearchProcessor extends StatefulWidget {
  final String searchTerm;
  const SearchProcessor({Key? key, required this.searchTerm}) : super(key: key);

  @override
  State<SearchProcessor> createState() => _SearchProcessorState();
}

class _SearchProcessorState extends State<SearchProcessor> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
