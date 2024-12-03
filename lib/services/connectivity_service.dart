import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ConnectivityService {
  // Singleton pattern
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  // Notification plugin
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Current connectivity status
  ConnectivityResult _currentStatus = ConnectivityResult.none;
  ConnectivityResult get currentStatus => _currentStatus;

  // Debounce for notifications
  DateTime? _lastNotificationTime;
  static const Duration NOTIFICATION_COOLDOWN = Duration(minutes: 5);

  // Initialize the service
  Future<void> init(BuildContext context) async {
    // Initialize notification plugin
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Set up initial connectivity check
    final result = await Connectivity().checkConnectivity();
    _handleConnectivityChange(context, result as ConnectivityResult);

    // Set up connectivity monitoring
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Use the first result in the list
      final ConnectivityResult result = results.first;
      _handleConnectivityChange(context, result);
    });
  }

  void _handleConnectivityChange(BuildContext context, ConnectivityResult result) {
    _currentStatus = result;

    // Prevent too frequent notifications
    if (_lastNotificationTime == null ||
        DateTime.now().difference(_lastNotificationTime!) > NOTIFICATION_COOLDOWN) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        _sendConnectivityNotification(true);
      } else if (result == ConnectivityResult.none) {
        _sendConnectivityNotification(false);
      }
      _lastNotificationTime = DateTime.now();
    }
  }

  void _sendConnectivityNotification(bool isConnected) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'connectivity_channel',
      'Connectivity Notifications',
      importance: Importance.low,
      priority: Priority.low,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      isConnected ? 'Connected to Internet' : 'No Internet Connection',
      isConnected
          ? 'You are currently connected to the internet'
          : 'You are currently not connected to the internet',
      platformChannelSpecifics,
    );
  }

  // Helper method to check if currently connected
  bool get isConnected =>
      _currentStatus == ConnectivityResult.wifi ||
          _currentStatus == ConnectivityResult.mobile;
}

// Optional: A reusable widget to handle no internet state
class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'No Internet Connection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please check your WiFi or mobile data',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}