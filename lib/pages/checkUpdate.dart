import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker {
  static Future<void> checkForUpdate(BuildContext context) async {
    final navigator = Navigator.of(context);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String packageName = packageInfo.packageName;

    // Capture platform before async gap
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    String? latestVersion;
    String? storeUrl;

    if (isIOS) {
      latestVersion = await _getIOSLatestVersion(packageName);

    } else {
      latestVersion = await _getAndroidLatestVersion(packageName);
      storeUrl = "https://play.google.com/store/apps/details?id=$packageName";
    }

    if (latestVersion != null &&
        _isNewVersionAvailable(currentVersion, latestVersion)) {
      // Use navigator.context to get fresh context after async gap
      if (navigator.mounted) {
        _showUpdateDialog(navigator.context, storeUrl!);
      }
    }
  }

  static Future<String?> _getAndroidLatestVersion(String packageName) async {
    try {
      final response = await http.get(Uri.parse(
          "https://play.google.com/store/apps/details?id=$packageName"));
      if (response.statusCode == 200) {
        RegExp versionExp = RegExp(r'\[\[\["([0-9]+\.[0-9]+\.[0-9]+)"\]\]');
        Match? match = versionExp.firstMatch(response.body);
        if (match != null) {
          return match.group(1);
        }
      }
    } catch (e) {
      if (kDebugMode) print("Error fetching Android app version: $e");
    }
    return null;
  }

  static Future<String?> _getIOSLatestVersion(String packageName) async {
    try {
      final response = await http.get(
          Uri.parse("https://itunes.apple.com/lookup?bundleId=$packageName"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        if ((json['results'] as List).isNotEmpty) {
          return json['results'][0]['version'];
        }
      }
    } catch (e) {
      if (kDebugMode) print("Error fetching iOS app version: $e");
    }
    return null;
  }

  static bool _isNewVersionAvailable(
      String currentVersion, String latestVersion) {
    List<int> currentParts = currentVersion.split('.').map(int.parse).toList();
    List<int> latestParts = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (i >= currentParts.length || latestParts[i] > currentParts[i]) {
        return true;
      } else if (latestParts[i] < currentParts[i]) {
        return false;
      }
    }
    return false;
  }

  static void _showUpdateDialog(BuildContext context, String storeUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Update Available"),
        content: Text("A new version of the app is available. Please update."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Later"),
          ),
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse(storeUrl),
                  mode: LaunchMode.externalApplication);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
