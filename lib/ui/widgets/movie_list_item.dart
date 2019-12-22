import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/view_models/details_view_model.dart';
import 'package:cinematic/ui/screens/movie_details_screen.dart';
import 'package:cinematic/ui/values/strings.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<Movie>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<DetailsViewModel>(
              create: (context) => DetailsViewModel(movie),
              key: ObjectKey(movie),
              child: MovieDetailsScreen(),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: CachedNetworkImage(
                width: 80,
                height: 120,
                placeholder: (context, url) => Container(
                    width: 80,
                    height: 120,
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: FULL_STAR,
                    ))),
                errorWidget: (context, url, error) => Container(
                    color: Colors.white24,
                    width: 80,
                    height: 120,
                    child: Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ))),
                imageUrl: '$IMAGE_URL${movie.posterPath}',
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    '${movie.title}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: movie.voteAverage / 2 ?? 0,
                      size: 25.0,
                      color: FULL_STAR,
                      borderColor: FULL_STAR,
                      spacing: 0.0),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    color: Colors.grey,
                    height: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
