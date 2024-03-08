import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the Movie class or use the actual path

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> _favoriteMovies = [];

  get favoriteMoviesIds => null;

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> FavoriteMovieIds = prefs.getKeys().where((key) => key.startsWith('movie_')).toList();
    setState(() {
      _favoriteMovies = favoriteMoviesIds.map((id){
        final String? movieJson = prefs.getString(id);
        if(movieJson != null && movieJson.isNotEmpty) {
          final Map<String, dynamic> movieData = jsonDecode(movieJson);
          return Movie.fromJson(movieData);

        }
        return null;

      })
      .where((movie) => movie != null)
      .cast<Movie>()
      .toList();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: _favoriteMovies.length,
        itemBuilder: (context, index) {
          final Movie movie = _favoriteMovies[index];

          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(movie.title),
            onTap: () {
              // Navigate to the DetailScreen when the ListTile is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Assuming you have a DetailScreen class that takes a Movie as a parameter
class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the UI for the detail screen based on the Movie data
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Center(
        child: Text('Details for ${movie.title}'),
      ),
    );
  }
}
