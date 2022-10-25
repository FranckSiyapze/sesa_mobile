import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sesa/ui/utils/colors.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/ecommerce_page/ecommerce_page.dart';
import 'package:sesa/ui/views/home_page/home_page.dart';
import 'package:sesa/ui/views/profile_page/profile_page.dart';
import 'package:sesa/ui/widgets/bottom_navigation/bottom_navigation_bar.dart';
import 'package:sesa/ui/widgets/bottom_navigation/bottom_navigation_bar_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late CustomAppTheme customAppTheme;
  TextEditingController _etMessage = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer(
      builder: (context, watch, child) {
        final themeProvider = watch(themeNotifierProvider);
        customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawerScrimColor: Colors.black87,
          key: _scaffoldKey,
          /* drawer: Drawer(
          scaffoldKey: _scaffoldKey,
          fadeInFadeOut: _fadeInFadeOut,
        ), */
          body: FxBottomNavigationBar(
            activeIconColor: kPrimary,
            iconColor: kUnselectedButton.withAlpha(140),
            activeContainerColor: kPrimary.withAlpha(30),
            activeIconSize: 24,
            iconSize: 24,
            itemList: [
              FxBottomNavigationBarItem(
                page: HomePage(),
                activeIconData: Icons.house,
                iconData: Icons.house_outlined,
              ),
              /* FxBottomNavigationBarItem(
              page: HomePage(),
              activeIconData: MdiIcons.hospital,
              iconData: MdiIcons.hospitalBoxOutline,
            ), */
              FxBottomNavigationBarItem(
                page: EcommercePage(
                  rootContext: context,
                ),
                activeIconData: MdiIcons.shopping,
                iconData: MdiIcons.shoppingOutline,
              ),
              FxBottomNavigationBarItem(
                page: MediCareProfileScreen(),
                activeIconData: Icons.person,
                iconData: Icons.person_outline,
              ),
            ],
            fxBottomNavigationBarType: FxBottomNavigationBarType.containered,
            backgroundColor: customAppTheme.kBackgroundColorFinal,
            showLabel: false,
            showActiveLabel: false,
            labelSpacing: 2,
            initialIndex: 0,
            labelDirection: Axis.horizontal,
          ),
          floatingActionButton: DraggableFab(
            initPosition: Offset(MediaQuery.of(context).size.width / 1.5,
                MediaQuery.of(context).size.height / 1.23),
            child: FloatingActionButton(
              onPressed: () async {
                //_scaffoldKey.currentState?.openDrawer();
                _showPopup3();
              },
              backgroundColor: kPrimary,
              child: Icon(
                MdiIcons.bellBadge,
                color: customAppTheme.kWhite,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPopup3() {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: 'Press Cancel', toastLength: Toast.LENGTH_SHORT);
        },
        child: Text('Fermer', style: TextStyle(color: kPrimary)));
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          //_getCurrentLocation();
        },
        child: Text('Envoyer', style: TextStyle(color: kPrimary)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Envoyer une URGENCE ',
        style: TextStyle(fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Détailler l\'urgence ici, préciser tous les détails nécessaire pour vous aider rapidement.',
            style: TextStyle(
              fontSize: 13,
              color: customAppTheme.colorTextFeed,
            ),
          ),
          TextField(
            autofocus: true,
            controller: _etMessage,
            style: TextStyle(color: customAppTheme.colorTextFeed),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimary,
                  width: 2.0,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
