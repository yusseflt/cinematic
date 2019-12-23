import 'dart:io';

import 'package:cinematic/ui/screens/home_screen.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;
  bool startLoading;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    startLoading = false;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          startLoading = true;
        }
      });

    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
    Future.delayed(Duration(milliseconds: 5000)).then((_) {
      isConnectedToInternet();
    });
  }

  Future<void> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('No internet connection found'),
          ),
        );
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text('No internet connection found'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                exit(0);
              },
              child: Text('Close app'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BACKGROUND_GREY,
        padding: EdgeInsets.all(100),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ScaleTransition(
                scale: animation,
                child: Image.asset('assets/LogoCinematic.png'),
              ),
            ),
            startLoading
                ? Expanded(child: Image.asset('assets/loading.gif'))
                : Expanded(
                    child: Container(),
                  )
          ],
        ),
      ),
    );
  }
}
