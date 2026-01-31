import 'package:flutter/material.dart';
import 'app_state.dart';
import 'inbox.dart';
import 'stocks.dart';
import 'widgets/top_section.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // ---------- TOP SECTION ----------
            const TopSection(),
            const SizedBox(height: 20),

            // ---------- MAIN GRID ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    FeatureTile(
                      icon: Icons.inbox,
                      label: 'Inbox',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InboxPage(),
                          ),
                        );
                      },
                    ),
                    FeatureTile(  // <- removed const here
                      icon: Icons.show_chart,
                      label: 'Stocks',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StocksPage(),
                          ),
                        );
                      },
                    ), 
                    const FeatureTile(
                      icon: Icons.account_balance_wallet,
                      label: 'Budgeting',
                    ),
                    const FeatureTile(
                      icon: Icons.pie_chart,
                      label: 'Portfolio',
                    ),
                  ],
                ),
              ),
            ),

            // ---------- BOTTOM NAV ----------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const Text(
                    'January',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- GRID TILE WIDGET ----------
class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool showUnread =
        label == 'Inbox' && hasUnreadInboxMail;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          children: [
            const Spacer(),

            Stack(
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: Colors.green,
                ),
                if (showUnread)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
