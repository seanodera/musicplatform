// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ErrorWidget extends StatefulWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoadingScreen extends StatelessWidget {
  final Color? color;
  const LoadingScreen({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 140,
              child: Card(
                  elevation: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Please wait a second ...',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator(
                              color: color,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
