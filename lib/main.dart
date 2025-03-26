import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/providers/theme_provider.dart';
import 'package:realtime_stock_analytics/views/auth/login_screen.dart';
import 'package:realtime_stock_analytics/views/auth/signup_screen.dart';
import 'package:realtime_stock_analytics/views/home/home_screen.dart';
import 'package:realtime_stock_analytics/views/stocks/stock_list_screen.dart';
import 'package:realtime_stock_analytics/views/news/news_feed_screen.dart';
import 'package:realtime_stock_analytics/views/settings/settings_screen.dart';

import 'controllers/sentiment_provider.dart';
import 'controllers/stock_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SentimentProvider()),
        ChangeNotifierProvider(create: (context) => StockProvider()),
      ],
      child: Builder(
        builder: (context) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, appProvider, child) {
        final brightness = appProvider.isDarkMode ? Brightness.dark : Brightness.light;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: brightness,
            primaryColor: const Color(0xFF1A237E), // Navy Blue
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A237E), // Navy Blue
              brightness: brightness,
              secondary: const Color(0xFFFFD700), // Gold
            ),
          ),
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/login':
                builder = (context) => LoginScreen();
                break;
              case '/signup':
                builder = (context) => SignupScreen();
                break;
              case '/home':
                builder = (context) => HomeScreen(); // Home with Bottom Navigation
                break;
              case '/stocks':
                builder = (context) => StockListScreen();
                break;
              case '/news':
                builder = (context) => NewsFeedScreen();
                break;
              case '/settings':
                builder = (context) => SettingsScreen();
                break;
              default:
                builder = (context) => LoginScreen();
            }

            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => builder(context),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1), // Slight slide up
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
            );
          },
          initialRoute: '/login',
        );
      },
    );
  }
}
