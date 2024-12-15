import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:damaz/services/languageProvider.dart';
import 'package:damaz/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            // Dark Mode Toggle
            _buildSettingsOption(
              context,
              title: AppLocalizations.of(context)!.darkMode,
              trailing: CupertinoSwitch(
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(),
              ),
            ),

            const SizedBox(height: 20),

            // Language Selection
            _buildSettingsOption(
              context,
              title: AppLocalizations.of(context)!.language,
              trailing: SingleChildScrollView(
                child: DropdownButton<String>(
                  value: languageProvider.locale.languageCode,
                  onChanged: (String? newLanguageCode) {
                    if (newLanguageCode != null) {
                      languageProvider.changeLanguage(newLanguageCode);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'fr',
                      child: Text('Français'),
                    ),
                    // DropdownMenuItem(
                    //   value: 'es',
                    //   child: Text('Español'),
                    // ),
                    // DropdownMenuItem(
                    //   value: 'rw',
                    //   child: Text('Kinya'),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a settings option
  Widget _buildSettingsOption(BuildContext context,
      {required String title, required Widget trailing}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
