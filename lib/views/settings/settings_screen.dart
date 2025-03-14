import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/providers/theme_provider.dart';
import 'package:realtime_stock_analytics/widgets/custom_toggle_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10),

          /// **Dark Mode Toggle**
          CustomToggleTile(
            title: "Dark Mode",
            subtitle: "Enable or disable dark theme",
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(),
          ),

          ///**Notifications Toggle**
          CustomToggleTile(
            title: "Notifications",
            subtitle: "Enable or disable push notifications",
            value: true, // TODO: Replace with actual setting
            onChanged: (value) {
              // TODO: Implement notification toggle logic
            },
          ),

          //**Sign Out**
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text("Sign Out", style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: Implement sign-out logic here//
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signing out...")),
              );
            },
          ),
        ],
      ),
    );
  }
}
