import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:realtime_stock_analytics/models/news_model.dart';

class NewsWebViewScreen extends StatefulWidget {
  final NewsModel news;

  const NewsWebViewScreen({super.key, required this.news});

  @override
  _NewsWebViewScreenState createState() => _NewsWebViewScreenState();
}

class _NewsWebViewScreenState extends State<NewsWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to load page: ${error.description}")),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.news.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.news.source)),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
