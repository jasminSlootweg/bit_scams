import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/mail.dart';
import 'mail_detail_view.dart';

class InboxPage extends StatefulWidget {
  final User user;
  const InboxPage({super.key, required this.user});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final Color primaryNavy = const Color.fromRGBO(2, 30, 67, 1);

  @override
  Widget build(BuildContext context) {
    // Separate mail into tabs based on age
    final newMail = widget.user.inbox.where((m) => !m.wasReadInPreviousMonth).toList();
    final pastMail = widget.user.inbox.where((m) => m.wasReadInPreviousMonth).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryNavy,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          // --- UPDATED TITLE: Text replaced with Image ---
          title: Image.asset(
            'assets/images/inbox_card.png',
            height: 40, // Adjusted height to fit the AppBar nicely
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.greenAccent,
            labelColor: Colors.greenAccent,
            unselectedLabelColor: Colors.white54,
            tabs: [Tab(text: 'NEW'), Tab(text: 'PAST')],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMailList(newMail),
            _buildMailList(pastMail),
          ],
        ),
      ),
    );
  }

  Widget _buildMailList(List<Mail> mails) {
    if (mails.isEmpty) {
      return const Center(
        child: Text("No messages", style: TextStyle(color: Colors.white24, fontSize: 18)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: mails.length,
      itemBuilder: (context, index) {
        final mail = mails[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Icon(
              mail is Offer ? Icons.monetization_on : Icons.newspaper,
              color: mail.isRead ? Colors.white24 : Colors.greenAccent,
            ),
            title: Text(
              mail.subject,
              style: TextStyle(
                color: Colors.white,
                fontWeight: mail.isRead ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            subtitle: Text(
              mail.body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white54),
            ),
            onTap: () async {
              setState(() => mail.isRead = true);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MailDetailView(mail: mail, user: widget.user),
                ),
              );

              setState(() {});
            },
          ),
        );
      },
    );
  }
}