import 'package:deepforge_app/Providers/Dark_Mode_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeetingScreen extends StatefulWidget {
  const SeetingScreen({super.key});

  @override
  State<SeetingScreen> createState() => _SeetingScreenState();
}

class _SeetingScreenState extends State<SeetingScreen> {
  @override
  Widget build(BuildContext context) {
    print('Rebuild');
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Version',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('3.1.1345 (300022856)'),
            ),
            const Divider(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Terms of Service',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Privacy policy',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Dark Mode', style: TextStyle(fontSize: 20)),
                ),
                Consumer<DarkMode>(builder: (context, themechanger, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Switch(
                      value: themechanger.themeMode == ThemeMode.dark,
                      onChanged: (_) {
                        themechanger.themMode();
                      },
                      activeColor: Colors.white,
                    activeTrackColor: Colors.blue,
                    ),
                  );
                })
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
