import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/providers/app_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<String> themeList = <String>['Light', 'Dark'];
  List<String> languageList = <String>['en', 'ar'];

  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfig>(context);
    String themeDropdownValue =
        appConfig.appTheme == ThemeMode.light ? 'Light' : 'Dark';

    String languageDropdownValue = appConfig.language ;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            color: AppTheme.primaryColor,
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
          ),
          PositionedDirectional(
            top: MediaQuery.of(context).size.height * 0.06,
            start: MediaQuery.of(context).size.width * 0.05,
            child: Text(
              AppLocalizations.of(context)!.settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ]),
        Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownMenu<String>(
                width: MediaQuery.of(context).size.width - 50,
                initialSelection: themeDropdownValue,
                onSelected: (String? value) {
                  setState(() {
                    if (value != null) {
                      appConfig.changeTheme(
                          value == 'Light' ? ThemeMode.light : ThemeMode.dark);
                      themeDropdownValue = value;
                    }
                  });
                },
                dropdownMenuEntries:
                    themeList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownMenu<String>(
                width: MediaQuery.of(context).size.width - 50,
                initialSelection: languageDropdownValue,
                onSelected: (String? value) {
                  setState(() {
                    if (value != null) {
                      appConfig.changeLanguage(
                          value == 'en' ? 'en' : 'ar');
                      languageDropdownValue = value;
                    }
                  });
                },
                dropdownMenuEntries:
                languageList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
