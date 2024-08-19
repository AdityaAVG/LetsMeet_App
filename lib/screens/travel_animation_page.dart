import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class TravelAnimationPage extends StatefulWidget {
  @override
  _TravelAnimationPageState createState() => _TravelAnimationPageState();
}

class _TravelAnimationPageState extends State<TravelAnimationPage>
    with TickerProviderStateMixin {
  List<String> travelQuotes = [];
  Random random = Random();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 200);
    Timer.periodic(duration, (Timer timer) {
      if (mounted) {
        setState(() {
          if (travelQuotes.length > 5) {
            travelQuotes.removeAt(0);
          }
          travelQuotes.add(_generateRandomQuote());
        });
      }
    });

    Future.delayed(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacementNamed('/MainWindow');
    });
  }

  String _generateRandomQuote() {
    List<String> quotes = [
      "Adventure awaits!",
      "Discover new friends on your journey.",
      "The world is full of connections.",
      "Travel far, meet near.",
      "Your next friend is just a trip away."
    ];
    return quotes[random.nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/travel_background.jpg', // Ensure you have this image in your assets
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/globe.gif', // You can replace with a short video if supported
                height: 150,
                width: 150,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: ListView.builder(
                itemCount: travelQuotes.length,
                itemBuilder: (context, index) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      travelQuotes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Courier',
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 400),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Setting up your journey...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
