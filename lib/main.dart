import 'package:cinematic/core/utils/remove_overscroll_effect.dart';
import 'package:cinematic/core/view_models/home_view_model.dart';
import 'package:cinematic/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel.instance(),
        )
      ],
      child: MaterialApp(
        builder: (context, child) => ScrollConfiguration(
          behavior: RemoveOverScrollEffect(),
          child: child,
        ),
        title: 'Cinematic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'OpenSans',
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
