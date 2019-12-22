import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/view_models/details_view_model.dart';
import 'package:cinematic/ui/screens/movie_details_screen.dart';
import 'package:cinematic/ui/values/strings.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieCard extends StatelessWidget {
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
        width: 160,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(60.0),
              child: CachedNetworkImage(
                width: 160,
                height: 210,
                placeholder: (context, url) => Container(
                    width: 160,
                    height: 210,
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: FULL_STAR,
                    ))),
                errorWidget: (context, url, error) => Container(
                    width: 160,
                    height: 210,
                    child: Center(child: Icon(Icons.error))),
                imageUrl: '$IMAGE_URL${movie.posterPath}',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              movie.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            SmoothStarRating(
                allowHalfRating: false,
                starCount: 5,
                rating: movie.voteAverage / 2 ?? 0,
                size: 25.0,
                color: FULL_STAR,
                borderColor: FULL_STAR,
                spacing: 0.0),
          ],
        ),
      ),
    );
  }
}
