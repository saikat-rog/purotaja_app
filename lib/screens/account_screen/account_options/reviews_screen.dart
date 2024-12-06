import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reviews = [
      {
        "name": "John Doe",
        "rating": 5,
        "comment": "Excellent app! Very user-friendly and efficient.",
      },
      {
        "name": "Jane Smith",
        "rating": 4,
        "comment": "Great experience, but room for improvement in features.",
      },
      {
        "name": "Alex Johnson",
        "rating": 3,
        "comment": "Decent app, but had some bugs in the payment section.",
      },
      {
        "name": "Maria Garcia",
        "rating": 5,
        "comment": "Absolutely loved it! Highly recommend this app.",
      },
      {
        "name": "Rajesh Kumar",
        "rating": 4,
        "comment": "Good app, but the UI could be more intuitive.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Row(
                children: [
                  Text(
                    review["name"],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 10),
                  _buildStars(review["rating"]),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  review["comment"],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper widget to display stars based on rating
  Widget _buildStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}
