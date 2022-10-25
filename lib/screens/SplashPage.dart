// ignore: file_names
import 'package:flutter/material.dart';
import 'package:musicplatform/podo/RouterManager.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static const String image = 'ic_splash.png';
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _countdownController;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _countdownController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _countdownController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      ProviderModel providerModel = Provider.of<ProviderModel>(context);
      providerModel.player.dispose();
      providerModel.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Add Your',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                  'Music',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    "assets/images/" + SplashPage.image,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  nextPage(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.only(right: 40, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: AnimatedCountdown(
                    context: context,
                    animation: StepTween(begin: 2, end: 0)
                        .animate(_countdownController),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, required this.animation, context})
      : super(key: key, listenable: animation) {
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //var value = animation.value + 1;
    return const Text(
      "Skip",
    );
  }
}

void nextPage(context) {
  Navigator.of(context).pushReplacementNamed(RouteName.tab);
}
