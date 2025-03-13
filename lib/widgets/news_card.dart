import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String source;
  final String timeAgo;

  const NewsCard({Key? key, required this.title, required this.source, required this.timeAgo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$source • $timeAgo"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
