import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/utils/custom_search_delegate.dart';
import 'package:cinematic/core/view_models/home_view_model.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:cinematic/ui/widgets/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Movies'),
        centerTitle: true,
        backgroundColor: BACKGROUND_BLUE,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          )
        ],
      ),
      body: Container(
        color: BACKGROUND_BLUE,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 32.0, left: 16.0),
              color: BACKGROUND_GREY,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                itemCount: homeViewModel.popularMoviesList.length,
                itemBuilder: (context, index) => Provider<Movie>(
                  create: (context) => homeViewModel.popularMoviesList[index],
                  key: ObjectKey(homeViewModel.popularMoviesList[index]),
                  child: MovieListItem(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: BACKGROUND_GREY,
              ),
              child: homeViewModel.actualPage >= homeViewModel.totalPagesPopular
                  ? Container()
                  : InkWell(
                      onTap: () {
                        homeViewModel.actualPage++;
                        homeViewModel.getPopular(homeViewModel.actualPage);
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Carregar mais',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
