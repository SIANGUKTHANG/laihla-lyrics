import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TextStyle styles = const TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
    color: Colors.white70,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, bottom: 10),
                height: MediaQuery.of(context).size.width / 6,
                child: Image.asset('assets/logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Laihla lyrics",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "Version 2.0",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              ..._buildSettingItems(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'laihla lyrics" app cu kan laimi nih kan serchuahmi hla tete kan thiamchin le a bia kan upat chin lengmang khawhnakhnga sermi app a si.A kan hmanpiak mi nan zate cung ah kan i lawm.Kan tialpalh mi a um sual ahcun a tang ah na kan pehtlaih naklai kan in nawl hna.',
                  style: TextStyle(fontSize: 14, color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSettingItems() {
    final items = [
      {'title': 'Request tuahnak', 'url': 'https://m.me/100290286104836'},
      {'title': 'Privacy Policy', 'url': 'https://sites.google.com/view/it-rungrul/home'},
    ];

    return items.map((item) {
      return Container(
        margin: const EdgeInsets.only(top: 20.0),
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          onTap: () async {
            final Uri url = Uri.parse(item['url']!);
            if (await canLaunchUrl(Uri.parse(url.toString()))) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              // Handle the error gracefully

              Get.snackbar('',  '',      backgroundColor: Colors.green,
                  titleText: const Center(child:  Text('Could not launch URL'))
              );


            }
          },
          title: Text(item['title']!, style: styles),
          trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.white70),
        ),
      );
    }).toList();
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
          backgroundColor: Colors.purple,
        ),
      ),
      content: Container(
        margin: const EdgeInsets.only(top: 14),
        child: const Text(
          'Updating data..',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
