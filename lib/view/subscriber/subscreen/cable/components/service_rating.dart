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
  List allRatings = [];
  List filterRating = [];
  @override
  void initState() {
    getRating().then((data) {
      setState(() {
        allRatings = filterRating = data;
      });
    });
    filterData(widget.ticketId);
    super.initState();
  }

  void filterData(value) {
    setState(() {
      filterRating = allRatings
          .where((rating) => rating['ticket_id'].contains(value.toString()))
          .toList();
    });
    print(filterRating);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: RatingBar.builder(
          initialRating: _rating,
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
            setState(() {
              _rating = rating;
            });
          },
        ),
      ),
    );
  }
}
