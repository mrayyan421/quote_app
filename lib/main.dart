import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:math';
import 'package:quote_app/screens/Quote_collection.dart';
import 'dart:ui';
import 'package:quote_app/screens/favQuotes.dart';

void main() {
  runApp(MyApp());
}

class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuoteOfTheDayScreen(),
    );
  }
}

class QuoteOfTheDayScreen extends StatefulWidget {
  const QuoteOfTheDayScreen({super.key});

  @override
  _QuoteOfTheDayScreenState createState() => _QuoteOfTheDayScreenState();
}

class _QuoteOfTheDayScreenState extends State<QuoteOfTheDayScreen> {
  late Quote _currentQuote;
  final List<Quote> _favoriteQuotes = [];
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _updateQuoteOfTheDay();
  }

  void _updateQuoteOfTheDay() {
    final random = Random();
    final randomIndex = random.nextInt(famousQuotes.length);
    final randomQuoteEntry = famousQuotes.entries.elementAt(randomIndex);

    setState(() {
      _currentQuote = Quote(
        content: randomQuoteEntry.key,
        author: randomQuoteEntry.value,
      );
    });
    _isFavorite = _favoriteQuotes.contains(_currentQuote);
  }

  void _viewFavoriteQuotes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FavoriteQuotesScreen(favoriteQuotes: _favoriteQuotes),
      ),
    );
  }

  void _shareQuote() {
    Share.share("${_currentQuote.content} - ${_currentQuote.author}");
  }

  void _addToFavorites() {
    setState(() {
      _favoriteQuotes.add(_currentQuote);
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        // Remove the quote from favorites and change the icon color to the default
        _favoriteQuotes.remove(_currentQuote);
        _isFavorite = false;
      } else {
        // Add the quote to favorites and change the icon color to red
        _favoriteQuotes.add(_currentQuote);
        _isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Today\'s quote',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 26,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent[400],
        onPressed: _updateQuoteOfTheDay,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/bg_img.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentQuote.content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 50,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            color: Colors.white60),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "- ${_currentQuote.author}",
                        style: TextStyle(fontSize: 18, color: Colors.white60),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : null,
                            ),
                            onPressed: _toggleFavorite,
                          ),
                          IconButton(
                              icon: Icon(Icons.share), onPressed: _shareQuote),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: _viewFavoriteQuotes,
                child: Text(
                  'View Favorite Quotes',
                  style: TextStyle(
                    color: Colors.teal, // Customize the button text color
                    fontSize: 18,
                  ),
                ),
              ),
            ),*/
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: _viewFavoriteQuotes,
              child: Text(
                'View Favorite Quotes',
                style: TextStyle(
                    color: Colors.teal, // Customize the button text color
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
