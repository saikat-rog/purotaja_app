import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, String>> notifications = [
    {"title": "Order Shipped", "body": "Your order #1234 has been shipped."},
    {"title": "Payment Received", "body": "We have received your payment."},
    {
      "title": "Welcome!",
      "body": "Thank you for signing up. Start exploring now!"
    },
    {"title": "Discount Alert", "body": "Get 20% off on your next order!"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          'No notifications available!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                notification['title']!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['body']!),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
