import 'package:damaz/data/expense_data.dart';
import 'package:damaz/pages/home_page.dart';
import 'package:damaz/pages/login_page.dart';
import 'package:damaz/pages/main_screen.dart';
import 'package:damaz/services/balance_provider.dart';
import 'package:damaz/services/languageProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'data/income_data.dart';
import 'firebase_options.dart';
import 'models/restaurant.dart';
import 'services/auth_gate.dart';
import 'services/connectivity_service.dart';
import 'services/battery_service.dart';
import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // intialize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox("expense_database");

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  final connectivityService = ConnectivityService();
  final batteryService = BatteryService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BalanceProvider()),
        ChangeNotifierProvider(create: (context) => IncomeData()),
        ChangeNotifierProvider(create: (context) => ExpenseData()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Restaurant()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()), // Add LanguageProvider
        Provider.value(value: connectivityService),
        Provider.value(value: batteryService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    connectivityService.init(context);

    final batteryService = Provider.of<BatteryService>(context, listen: false);
    batteryService.init();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      routes:{
        '/mainScreen': (context) =>  MainScreen(),
        '/loginPage': (context) => const LoginPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      locale: languageProvider.locale, // Use the locale from LanguageProvider
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
        Locale('fr', ''),
        Locale('rw', ''),
      ],
    );
  }
}
