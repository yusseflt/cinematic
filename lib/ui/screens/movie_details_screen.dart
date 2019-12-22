import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematic/core/view_models/details_view_model.dart';
import 'package:cinematic/ui/values/strings.dart';
import 'package:cinematic/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detailsViewModel = Provider.of<DetailsViewModel>(context);
    return Scaffold(
      body: Container(
        child: Container(
          color: BACKGROUND_GREY,
          child: detailsViewModel.movieDetails == null
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: FULL_STAR,
                  ),
                )
              : ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Center(
                          child: CachedNetworkImage(
                            height: 240,
                            fit: BoxFit.fitWidth,
                            errorWidget: (context, url, error) => Container(
                                color: Colors.white24,
                                width: 80,
                                height: 120,
                                child: Center(
                                    child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ))),
                            placeholder: (context, url) => Container(
                                width: double.infinity,
                                height: 240,
                                child: Image.asset('assets/loading.gif')),
                            imageUrl:
                                '$IMAGE_URL${detailsViewModel.movieDetails.backdropPath}',
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 200,
                                child: Text(
                                  detailsViewModel.movieDetails.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/4k-fullhd.png',
                                color: Colors.grey,
                                scale: 2,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(48)),
                                color: Colors.grey,
                                onPressed: () {},
                                child: Text(
                                  'WATCH NOW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: detailsViewModel
                                              .movieDetails.voteAverage /
                                          2 ??
                                      0,
                                  size: 25.0,
                                  color: Colors.yellow,
                                  borderColor: Colors.yellow,
                                  spacing: 0.0),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            detailsViewModel.movieDetails.overview,
                            style: TextStyle(color: Colors.grey, height: 1.5),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Studio: ',
                                style:
                                    TextStyle(color: Colors.white, height: 1.5),
                              ),
                              Expanded(
                                child: Text(
                                  detailsViewModel.formatStringGroups(
                                      detailsViewModel
                                          .movieDetails.productionCompanies),
                                  style: TextStyle(
                                      color: Colors.grey, height: 1.5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Genres: ',
                                style:
                                    TextStyle(color: Colors.white, height: 1.5),
                              ),
                              Expanded(
                                child: Text(
                                  detailsViewModel.formatStringGroups(
                                      detailsViewModel.movieDetails.genres),
                                  style: TextStyle(
                                      color: Colors.grey, height: 1.5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Release Date: ',
                                style:
                                    TextStyle(color: Colors.white, height: 1.5),
                              ),
                              Text(
                                detailsViewModel.movieDetails.releaseDate ==
                                        null
                                    ? 'Uninformed'
                                    : '${DateTime.parse(detailsViewModel.movieDetails.releaseDate.toString()).year}',
                                style:
                                    TextStyle(color: Colors.grey, height: 1.5),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
