import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/mail.dart';

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
    // Filtering logic to separate tabs
    final newMail = widget.user.inbox.where((m) => !m.wasReadInPreviousMonth).toList();
    final pastMail = widget.user.inbox.where((m) => m.wasReadInPreviousMonth).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryNavy,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Inbox'),
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
      return const Center(child: Text("Empty", style: TextStyle(color: Colors.white24)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mails.length,
      itemBuilder: (context, index) {
        final mail = mails[index];
        return ListTile(
          title: Text(mail.subject, style: const TextStyle(color: Colors.white)),
          onTap: () {
            setState(() => mail.isRead = true);
            // Show detail dialog...
          },
        );
      },
    );
  }
}