import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatFactWidget extends StatelessWidget {
  final String imageUrl;
  final String fact;
  final String date;

  CatFactWidget({
    required this.imageUrl,
    required this.fact,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: 300,
          height: 300,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(fact),
              SizedBox(height: 10),
              Text('Дата: $date'),
            ],
          ),
        ),
      ],
    );
  }
}