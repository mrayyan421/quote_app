import 'package:flutter/material.dart';
import 'package:quote_app/main.dart';

class FavoriteQuotesScreen extends StatefulWidget {
  final List<Quote> favoriteQuotes; // Add this line

  FavoriteQuotesScreen({required this.favoriteQuotes}); // Add this constructor

  @override
  _FavoriteQuotesScreenState createState() => _FavoriteQuotesScreenState();
}

class _FavoriteQuotesScreenState extends State<FavoriteQuotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          'Favorite Quotes',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 26,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
      ),
      body: Container(
        color: Colors.teal[400],
        child: ListView.builder(
          itemCount: widget.favoriteQuotes
              .length, // Access the favoriteQuotes list from the widget
          itemBuilder: (context, index) {
            final quote = widget.favoriteQuotes[index];
            return ListTile(
              title: Text(quote.content),
              subtitle: Text("- ${quote.author}"),
            );
          },
        ),
      ),
    );
  }
}
