import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gtpl_operator/api_layer/model/rating_model.dart';
import 'package:gtpl_operator/api_layer/networking.dart';

class StarRating extends StatefulWidget {
  const StarRating({Key? key, required this.ticketId}) : super(key: key);
  final String ticketId;
  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  double _rating = 0.0;
  late final Future<Rating> ratingData;

  @override
  void initState() {
    ratingData = getRating(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Rating>(
        future: ratingData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Rating? data = snapshot.data;
            return SizedBox(
              height: 50,
              child: Center(
                child: RatingBar.builder(
                  initialRating: data!.star.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    this._rating = rating;
                    print(rating);
                    print("variable rating ---> $_rating");
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
