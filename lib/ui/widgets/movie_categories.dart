import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/ui/screens/search_screen.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:cinematic/ui/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Movie>>(context);
    return Container(
      child: Container(
        width: double.infinity,
        height: 300,
        child: list.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: FULL_STAR,
                ),
              )
            : ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Provider<Movie>(
                  create: (context) => list[index],
                  child: index == 4
                      ? Container(
                          margin: EdgeInsets.only(right: 16, left: 4),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'See all',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        )
                      : MovieCard(),
                ),
              ),
      ),
    );
  }
}
