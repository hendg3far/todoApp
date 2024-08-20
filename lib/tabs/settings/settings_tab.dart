import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: AppTheme.primaryColor,
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
            ),
            PositionedDirectional(
              top: MediaQuery.of(context).size.height * 0.06,
              start: MediaQuery.of(context).size.width * 0.05,
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ]
        ),
      ],
    );
  }
}
