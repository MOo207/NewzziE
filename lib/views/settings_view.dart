import 'package:flutter/material.dart';
import 'package:newzzie/widgets/language_button_change.dart';
import 'package:newzzie/widgets/theme_button_widget.dart';
import 'package:newzzie/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, true),
        body: Column(children: <Widget>[
          Container(
              height: 200,
              child: ListView(
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dark_mode),
                    leading: Icon(Icons.dark_mode_outlined),
                    trailing: ChangeThemeButtonWidget(),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.change_language),
                    leading: Icon(Icons.translate),
                    trailing: ChangeLanguageButton(),
                  )
                ],
              ))
        ]));
  }
}
