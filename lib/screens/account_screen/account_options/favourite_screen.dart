import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<String> favoriteItems = [
    'Pizza',
    'Burger',
    'Ice Cream',
    'Pasta',
    'Sushi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: favoriteItems.isEmpty
          ? Center(
        child: Text(
          'No favorites added yet!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      )
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(favoriteItems[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    favoriteItems.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
