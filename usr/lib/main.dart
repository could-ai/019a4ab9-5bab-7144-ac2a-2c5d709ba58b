import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Robbery Chase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      home: const PoliceChaseScreen(),
    );
  }
}

class PoliceChaseScreen extends StatefulWidget {
  const PoliceChaseScreen({super.key});

  @override
  State<PoliceChaseScreen> createState() => _PoliceChaseScreenState();
}

class _PoliceChaseScreenState extends State<PoliceChaseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Robbery Chase'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Container(color: Colors.grey.shade800),
          // Road
          Center(
            child: Container(
              height: 200,
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(), // for spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        10,
                        (i) => Container(
                            width: 30, height: 4, color: Colors.white54)),
                  ),
                  Container(), // for spacing
                ],
              ),
            ),
          ),
          // Bank Building
          Positioned(
            top: 40,
            left: 30,
            child: Row(
              children: [
                const Icon(Icons.account_balance,
                    color: Colors.white, size: 50),
                const SizedBox(width: 10),
                const Text(
                  'City Bank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          // Animated cars
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Use a CurvedAnimation to make movement smoother
              final animationValue = CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOut,
              ).value;

              // Robber's car position
              final robberCarX = -100 + (screenWidth + 100) * animationValue;
              // Police car position (lags behind)
              final policeCarX = -180 + (screenWidth + 100) * animationValue;

              return Stack(
                children: [
                  // Robber's car
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 40,
                    left: robberCarX,
                    child: const Car(
                      icon: Icons.directions_car,
                      color: Colors.redAccent,
                    ),
                  ),
                  // Police car
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 + 30,
                    left: policeCarX,
                    child: const Car(
                      icon: Icons.local_police,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class Car extends StatelessWidget {
  final IconData icon;
  final Color color;
  const Car({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 60,
      color: color,
      shadows: const [
        Shadow(
          blurRadius: 10.0,
          color: Colors.black,
          offset: Offset(5.0, 5.0),
        ),
      ],
    );
  }
}
