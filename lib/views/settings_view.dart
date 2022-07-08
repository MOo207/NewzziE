import 'package:flutter/material.dart';
import 'package:newzzie/helper/theme_button_widget.dart';
import 'package:newzzie/helper/widgets.dart';
import 'package:newzzie/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: myAppBar(true),
        body: Column(children: <Widget>[
          Container(
            height: 200,
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Change Theme"),
                    leading: Icon(Icons.dark_mode_outlined),
                    trailing: ChangeThemeButtonWidget(),
                  ),
                  ListTile(
                    title: Text("Change Language"),
                    leading: Icon(Icons.dark_mode_outlined),
                    // trailing: ChangeLanguageButton(),
                  ),
                ],
              ))
        ]));
  }
}
