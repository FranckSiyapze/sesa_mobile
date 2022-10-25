import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/star_rating.dart';
import 'package:sesa/ui/utils/themes/app_theme.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/home_page/models/category.dart';
import 'package:sesa/ui/views/home_page/models/doctor.dart';
import 'package:sesa/ui/widgets/card/card.dart';
import 'package:sesa/ui/widgets/container/container.dart';
import 'package:sesa/ui/widgets/text/text.dart';
import 'package:sesa/ui/widgets/text_field/text_field.dart';import 'package:flutter/cupertino.dart';

class MediCareProfileScreen extends StatefulWidget {
  const MediCareProfileScreen({Key? key}) : super(key: key);

  @override
  _MediCareProfileScreenState createState() => _MediCareProfileScreenState();
}

class _MediCareProfileScreenState extends State<MediCareProfileScreen> {
  late CustomAppTheme customAppTheme;
  Widget _buildSingleRow({String? title, IconData? icon}) {
    return Row(
      children: [
        FxContainer(
          paddingAll: 8,
          borderRadiusAll: 4,
          color: customAppTheme.kBackgroundColor,
          child: Icon(
            icon,
            color: AppTheme.customTheme.medicarePrimary,
            size: 20,
          ),
        ),
        FxSpacing.width(16),
        Expanded(
          child: FxText.caption(
            title!,
            letterSpacing: 0.5,
                color: customAppTheme.colorTextFeed,
          ),
        ),
        FxSpacing.width(16),
        Icon(
          Icons.keyboard_arrow_right,
          color: customAppTheme.kBackgroundColor.withAlpha(160),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final themeProvider = watch(themeNotifierProvider);
        customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
        return Scaffold(
          backgroundColor: customAppTheme.kBackgroundColorFinal,
          body: ListView(
            padding: FxSpacing.fromLTRB(24, 48, 24, 24),
            children: [
              FxSpacing.height(24),
              Center(
                child: FxContainer(
                  paddingAll: 0,
                  borderRadiusAll: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      image: AssetImage('assets/images/avatar_4.jpg'),
                    ),
                  ),
                ),
              ),
              FxSpacing.height(24),
              FxText.h6(
                'Franck Dabryn SIYAPZE',
                textAlign: TextAlign.center,
                fontWeight: 600,
                letterSpacing: 0.8,
                  color: customAppTheme.colorTextFeed,
              ),
              FxSpacing.height(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FxContainer.rounded(
                    color: AppTheme.customTheme.medicarePrimary,
                    height: 6,
                    width: 6,
                    child: Container(),
                  ),
                  FxSpacing.width(6),
                  FxText.button(
                    'Premium (9 days)',
                    color: AppTheme.customTheme.medicarePrimary,
                    muted: true,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              FxSpacing.height(24),
              FxText.caption(
                'General',
                color: FxAppTheme.theme.colorScheme.onBackground,
                xMuted: true,
              ),
              FxSpacing.height(24),
              _buildSingleRow(
                  title: 'Subscription & payment', icon: MdiIcons.creditCard),
              FxSpacing.height(8),
              Divider(),
              FxSpacing.height(8),
              _buildSingleRow(title: 'Profile settings', icon: Icons.person),
              FxSpacing.height(8),
              Divider(),
              FxSpacing.height(8),
              _buildSingleRow(title: 'Password', icon: MdiIcons.lock),
              FxSpacing.height(8),
              Divider(),
              FxSpacing.height(8),
              _buildSingleRow(title: 'Notifications', icon: MdiIcons.bell),
              FxSpacing.height(8),
              Divider(),
              FxSpacing.height(8),
              Row(
                children: [
                  FxContainer(
                    paddingAll: 8,
                    borderRadiusAll: 4,
                    color:
                        FxAppTheme.theme.colorScheme.onBackground.withAlpha(20),
                    child: Icon(
                      Icons.dark_mode,
                      color: AppTheme.customTheme.medicarePrimary,
                      size: 20,
                    ),
                  ),
                  FxSpacing.width(16),
                  Expanded(
                    child: FxText.caption(
                      "Mode Dark",
                      letterSpacing: 0.5,
                color: customAppTheme.colorTextFeed,
                    ),
                  ),
                  FxSpacing.width(16),
                  CupertinoSwitch(
                    value: themeProvider.value(),
                    onChanged: (value) {
                      if (themeProvider.themeMode() == 1) {
                        themeProvider.updateTheme(2, true);
                      } else {
                        themeProvider.updateTheme(1, false);
                      }
                      print(themeProvider.themeMode());
                      //state = value;
                      //print(value);

                      setState(() {});
                    },
                  ),
                ],
              ),
              Divider(),
              FxSpacing.height(8),
              _buildSingleRow(title: 'Logout', icon: MdiIcons.logout),
            ],
          ),
        );
      },
    );
  }
}
