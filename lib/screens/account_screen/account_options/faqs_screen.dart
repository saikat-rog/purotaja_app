import 'package:flutter/material.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  final List<Map<String, String>> faqs = [
    {
      "question": "What is this app about?",
      "answer":
      "This app allows you to explore, shop, and manage your account seamlessly."
    },
    {
      "question": "How do I track my orders?",
      "answer":
      "Go to the 'My Orders' section in your account to view and track all your orders."
    },
    {
      "question": "How can I update my personal information?",
      "answer":
      "Navigate to 'Personal Info' in your account settings to update your details."
    },
    {
      "question": "What payment methods are supported?",
      "answer":
      "We support credit/debit cards, UPI, net banking, and wallet payments."
    },
    {
      "question": "How do I contact customer support?",
      "answer":
      "You can reach out to us through the 'Help' section or email us at support@example.com."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ExpansionTile(
              title: Text(
                faq['question']!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    faq['answer']!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
