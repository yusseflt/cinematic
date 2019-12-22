import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/view_models/home_view_model.dart';
import 'package:cinematic/ui/screens/search_screen.dart';
import 'package:cinematic/ui/values/strings.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:cinematic/ui/widgets/movie_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      body: Container(
        color: BACKGROUND_BLUE,
        child: ListView(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  'Hello, what do you want to watch?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: 20.0, left: 15.0, bottom: 20.0, right: 15.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white60,
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.white54),
                  hintText: 'Search',
                  fillColor: Colors.white24,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                controller: _textController,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 32.0, left: 16.0),
              decoration: BoxDecoration(
                color: BACKGROUND_GREY,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // <---------------- now playing -------------->
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          NOW_PLAYING_TEXT.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  Provider<List<Movie>>(
                    create: (context) => homeViewModel.nowPlayingList,
                    child: MovieCategories(),
                  ),
                  // <---------------- popular -------------->
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          POPULAR_TEXT.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  Provider<List<Movie>>(
                    create: (context) => homeViewModel.popularMoviesList,
                    child: MovieCategories(),
                  ),
                  // <---------------- top rated -------------->
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          TOP_RATED_TEXT.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  Provider<List<Movie>>(
                    create: (context) => homeViewModel.topRatedList,
                    child: MovieCategories(),
                  ),
                  // <---------------- upcoming -------------->
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          UPCOMING_TEXT.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  Provider<List<Movie>>(
                    create: (context) => homeViewModel.upcomingMoviesList,
                    child: MovieCategories(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
