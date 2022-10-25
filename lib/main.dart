import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicplatform/podo/FavouriteModel.dart';
import 'package:musicplatform/podo/HomeModel.dart';
import 'package:musicplatform/podo/StorageManager.dart';
import 'package:musicplatform/podo/TempData.dart';
import 'package:musicplatform/podo/ThemeProvider.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:provider/provider.dart';
import 'podo/RouterManager.dart' as router;

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderModel>(
            create: (context) => ProviderModel()),
        ChangeNotifierProvider<ThemeModel>(create: (context) => ThemeModel()),
        ChangeNotifierProvider<Favourites>(create: (context) => Favourites()),
        ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel()),
      ],
      child: Consumer3<ProviderModel, ThemeModel, Favourites>(
          builder: ((context, providerModel, themeModel, favourites, child) {
        favourites.init;

        Database().getCharts().then((value) {
          // providerModel.queue = value;
        });
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeModel.themeData(),
          darkTheme: themeModel.themeData(platformDarkMode: true),
          themeMode: ThemeMode.dark,
          initialRoute: router.RouteName.splash,
          onGenerateRoute: router.Router.generateRoute,
        );
      })),
    );
  }
}
