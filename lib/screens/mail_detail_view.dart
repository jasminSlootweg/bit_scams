import 'package:flutter/material.dart';
import '../models/mail.dart';
import '../models/user.dart';

class MailDetailView extends StatelessWidget {
  final Mail mail;
  final User user;

  const MailDetailView({super.key, required this.mail, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(2, 30, 67, 1),
      appBar: AppBar(
        title: const Text("Message Details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mail.subject,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.white24, height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  mail.body,
                  style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.5),
                ),
              ),
            ),
            
            // --- CONDITIONAL BUTTON AREA ---
            
            if (mail is Offer) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  bool success = user.invest(mail as Offer);
                  if (success) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Investment Successful!")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Not enough cash!")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text("Invest \$${(mail as Offer).investmentCost}"),
              ),
            ] else ...[
              // If it's just News (like the Welcome email), show a simple "Done" button
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Center(
                  child: Text("Back to Inbox", style: TextStyle(color: Colors.greenAccent, fontSize: 16)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}