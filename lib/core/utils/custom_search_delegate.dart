import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/view_models/home_view_model.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:cinematic/ui/widgets/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  String oldQuery = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    if (oldQuery != query && query != '') {
      homeViewModel.searchMovie(query, 1);
      oldQuery = query;
    }

    return Container(
      color: BACKGROUND_GREY,
      child: homeViewModel.searching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : homeViewModel.noMovie
              ? Container(
                  child: Center(
                    child: Text(
                      'No movie was found :(',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : ListView(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: homeViewModel.searchList.length,
                      itemBuilder: (context, index) => Provider<Movie>(
                        create: (context) => homeViewModel.searchList[index],
                        key: ObjectKey(homeViewModel.searchList[index]),
                        child: MovieListItem(),
                      ),
                    ),
                    homeViewModel.actualPage >= homeViewModel.totalSearchPage ||
                            query == ''
                        ? Container()
                        : InkWell(
                            onTap: () {
                              homeViewModel.actualPage++;

                              homeViewModel.searchMovie(
                                  query, homeViewModel.actualPage);
                            },
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Carregar mais',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          )
                  ],
                ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
