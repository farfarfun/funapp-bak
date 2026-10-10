import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:funapp/page/route.dart';

/// 展示应用设置页。
///
/// 不接收额外参数，页面内负责提供网络、开发者模式和 SecretKey 配置项。
class AppSettings extends StatefulWidget {
  /// 创建应用设置页。
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: 'Application Settings',
      children: [
        SettingsGroup(
          title: 'Single Choice Settings',
          children: <Widget>[
            SwitchSettingsTile(
              settingKey: 'key-wifi',
              title: 'Wi-Fi',
              subtitle: 'Wi-Fi allows interacting with the local network '
                  'or internet via connecting to a W-Fi router',
              enabledLabel: 'Enabled',
              disabledLabel: 'Disabled',
              leading: const Icon(Icons.wifi),
            ),
            CheckboxSettingsTile(
              settingKey: 'key-blue-tooth',
              title: 'Bluetooth',
              subtitle: 'Bluetooth allows interacting with the '
                  'near by bluetooth enabled devices',
              enabledLabel: 'Enabled',
              disabledLabel: 'Disabled',
              leading: const Icon(Icons.bluetooth),
            ),
            SwitchSettingsTile(
              leading: const Icon(Icons.developer_mode),
              settingKey: 'key-switch-dev-mode',
              title: 'Developer Settings',
              childrenIfEnabled: <Widget>[
                CheckboxSettingsTile(
                  leading: const Icon(Icons.adb),
                  settingKey: 'key-is-developer',
                  title: 'Developer Mode',
                  defaultValue: true,
                ),
                SwitchSettingsTile(
                  leading: const Icon(Icons.usb),
                  settingKey: 'key-is-usb-debugging',
                  title: 'USB Debugging',
                ),
                SimpleSettingsTile(
                  title: 'Root Settings',
                  subtitle: 'These setting is not accessible',
                  enabled: false,
                ),
                SimpleSettingsTile(
                  title: 'Custom Settings',
                  subtitle: 'Tap to execute custom callback',
                ),
              ],
            ),
            SimpleSettingsTile(
              title: 'More Settings',
              subtitle: 'General App Settings',
              child: SettingsScreen(
                title: 'App Settings',
                children: <Widget>[
                  CheckboxSettingsTile(
                    leading: const Icon(Icons.adb),
                    settingKey: 'key-is-developer',
                    title: 'Developer Mode',
                  ),
                  SwitchSettingsTile(
                    leading: const Icon(Icons.usb),
                    settingKey: 'key-is-usb-debugging',
                    title: 'USB Debugging',
                  ),
                ],
              ),
            ),
            // TextInputSettingsTile(
            //   title: 'User Name',
            //   settingKey: 'key-user-name',
            //   initialValue: 'admin',
            //   validator: (String? username) {
            //     if (username != null && username.length > 3) {
            //       return null;
            //     }
            //     return "User Name can't be smaller than 4 letters";
            //   },
            //   borderColor: Colors.blueAccent,
            //   errorColor: Colors.deepOrangeAccent,
            // ),
            // TextInputSettingsTile(
            //   title: 'password',
            //   settingKey: 'key-user-password',
            //   obscureText: true,
            //   validator: (String? password) {
            //     if (password != null && password.length > 6) {
            //       return null;
            //     }
            //     return "Password can't be smaller than 7 letters";
            //   },
            //   borderColor: Colors.blueAccent,
            //   errorColor: Colors.deepOrangeAccent,
            // ),
            SimpleSettingsTile(
              title: 'SecretKey',
              subtitle:
                  'Use --dart-define=FUNAPP_SECRET_KEY=... when starting the app',
              enabled: false,
            ),
            ModalSettingsTile(
              title: 'Quick setting dialog',
              subtitle: 'Settings on a dialog',
              children: <Widget>[
                CheckboxSettingsTile(
                  settingKey: 'key-day-light-savings',
                  title: 'Daylight Time Saving',
                  enabledLabel: 'Enabled',
                  disabledLabel: 'Disabled',
                  leading: const Icon(Icons.timelapse),
                ),
                SwitchSettingsTile(
                  settingKey: 'key-dark-mode',
                  title: 'Dark Mode',
                  enabledLabel: 'Enabled',
                  disabledLabel: 'Disabled',
                  leading: const Icon(Icons.palette),
                ),
              ],
            ),
            ExpandableSettingsTile(
              title: 'Quick setting 2',
              subtitle: 'Expandable Settings',
              expanded: true,
              children: <Widget>[
                CheckboxSettingsTile(
                  settingKey: 'key-day-light-savings-2',
                  title: 'Daylight Time Saving',
                  enabledLabel: 'Enabled',
                  disabledLabel: 'Disabled',
                  leading: const Icon(Icons.timelapse),
                ),
                SwitchSettingsTile(
                  settingKey: 'key-dark-mode-2',
                  title: 'Dark Mode',
                  enabledLabel: 'Enabled',
                  disabledLabel: 'Disabled',
                  leading: const Icon(Icons.palette),
                ),
              ],
            ),
          ],
        ),
        SettingsGroup(
          title: 'Multiple choice settings',
          children: <Widget>[
            RadioSettingsTile<int>(
              title: 'Preferred Sync Period',
              settingKey: 'key-radio-sync-period',
              values: const <int, String>{
                0: 'Never',
                1: 'Daily',
                7: 'Weekly',
                15: 'Fortnight',
                30: 'Monthly',
              },
              selected: 0,
            ),
            DropDownSettingsTile<int>(
              title: 'E-Mail View',
              settingKey: 'key-dropdown-email-view',
              values: const <int, String>{
                2: 'Simple',
                3: 'Adjusted',
                4: 'Normal',
                5: 'Compact',
                6: 'Squizzed',
              },
              selected: 2,
            ),
          ],
        ),
        ModalSettingsTile(
          title: 'Group Settings',
          subtitle: 'Same group settings but in a dialog',
          children: <Widget>[
            SimpleRadioSettingsTile(
              title: 'Sync Settings',
              settingKey: 'key-radio-sync-settings',
              values: const <String>[
                'Never',
                'Daily',
                'Weekly',
                'Fortnight',
                'Monthly',
              ],
              selected: 'Daily',
            ),
            SimpleDropDownSettingsTile(
              title: 'Beauty Filter',
              settingKey: 'key-dropdown-beauty-filter',
              values: const <String>[
                'Simple',
                'Normal',
                'Little Special',
                'Special',
                'Extra Special',
                'Bizarre',
                'Horrific',
              ],
              selected: 'Special',
            )
          ],
        ),
        ExpandableSettingsTile(
          title: 'Expandable Group Settings',
          subtitle: 'Group of settings (expandable)',
          children: <Widget>[
            RadioSettingsTile<double>(
              title: 'Beauty Filter',
              settingKey: 'key-radio-beauty-filter-expandable',
              values: <double, String>{
                1.0: 'Simple',
                1.5: 'Normal',
                2.0: 'Little Special',
                2.5: 'Special',
                3.0: 'Extra Special',
                3.5: 'Bizarre',
                4.0: 'Horrific',
              },
              selected: 2.5,
            ),
            DropDownSettingsTile<int>(
              title: 'Preferred Sync Period',
              settingKey: 'key-dropdown-sync-period-2',
              values: const <int, String>{
                0: 'Never',
                1: 'Daily',
                7: 'Weekly',
                15: 'Fortnight',
                30: 'Monthly',
              },
              selected: 0,
            )
          ],
        ),
        SettingsGroup(
          title: 'Other settings',
          children: <Widget>[
            SliderSettingsTile(
              title: 'Volume [Auto-Adjusting to 20]',
              settingKey: 'key-slider-volume',
              defaultValue: 20,
              min: 0,
              max: 100,
              step: 1,
              leading: const Icon(Icons.volume_up),
              decimalPrecision: 0,
              onChange: (value) {
                Future.delayed(const Duration(seconds: 1), () {
                  // Reset value only if the current value is not 20
                  if (Settings.getValue('key-slider-volume') != 20) {
                    Settings.setValue('key-slider-volume', 20.0, notify: true);
                  }
                });
              },
            ),
            ColorPickerSettingsTile(
              settingKey: 'key-color-picker',
              title: 'Accent Color',
              defaultValue: Colors.blue,
            )
          ],
        ),
        ModalSettingsTile(
          title: 'Other settings',
          subtitle: 'Other Settings in a Dialog',
          children: <Widget>[
            SliderSettingsTile(
              title: 'Custom Ratio',
              settingKey: 'key-custom-ratio-slider-2',
              defaultValue: 2.5,
              min: 1,
              max: 5,
              step: 0.1,
              decimalPrecision: 1,
              leading: const Icon(Icons.aspect_ratio),
            ),
            ColorPickerSettingsTile(
              settingKey: 'key-color-picker-2',
              title: 'Accent Picker',
              defaultValue: Colors.blue,
            )
          ],
        )
      ],
    );
  }
}

// void main() {
//   initSettings().then((accentColor) {
//     runApp(MyHomePage());
//   });
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'App Settings Demo', home: SettingBody());
//   }
// }

class SettingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Settings.clearCache();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('cleared cache',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).primaryColor,
            ));
          },
          child: const Text('clear cache'),
        ),
        const SizedBox(
          height: 25.0,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(WGRouter.pathSetting);
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const AppSettings(),
            // ));
            //openAppSettings(context);
          },
          child: const Text('Setting'),
        ),
      ],
    );
  }
}
