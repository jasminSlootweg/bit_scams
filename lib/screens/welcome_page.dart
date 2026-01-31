import 'package:flutter/material.dart';
import 'user_creation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sidePadding = 20.0;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(2, 30, 67, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---------- LOGO ----------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: Image.asset(
                  'assets/images/Stonks_logo.png',
                  width: screenWidth - (sidePadding * 2),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.monetization_on, size: 100, color: Colors.green),
                ),
              ),

              const SizedBox(height: 10),

              // ---------- TITLE ASSET ----------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: Image.asset(
                  'assets/images/Title_Page_Asset.png',
                  width: screenWidth - (sidePadding * 2),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Text(
                    "BIT SCAMS",
                    style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // ---------- START BUTTON ----------
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserCreationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                child: const Text('Start', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 20),

              // ---------- SETTINGS BUTTON ----------
              OutlinedButton(
                onPressed: () {
                   // Add settings logic here
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  side: const BorderSide(color: Colors.white38, width: 2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Settings', style: TextStyle(fontSize: 18)),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}