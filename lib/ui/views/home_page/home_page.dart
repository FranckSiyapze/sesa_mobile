import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sesa/core/controllers/doctors_controllers.dart';
import 'package:sesa/core/models/doctors/doctor_data.dart';
import 'package:sesa/core/models/doctors/user.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/star_rating.dart';
import 'package:sesa/ui/utils/styles/style.dart';
import 'package:sesa/ui/utils/themes/app_theme.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/doctor_page/doctor_page.dart';
import 'package:sesa/ui/views/home_page/models/category.dart';
import 'package:sesa/ui/views/home_page/models/doctor.dart';
import 'package:sesa/ui/widgets/card/card.dart';
import 'package:sesa/ui/widgets/container/container.dart';
import 'package:sesa/ui/widgets/text/text.dart';
import 'package:sesa/ui/widgets/text_field/text_field.dart';
import 'package:getwidget/getwidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late CustomAppTheme customAppTheme;
  int selectedCategory = 0;
  List<Category> categoryList = [];
  List<Doctor> doctorList = [];
  late DoctorData _doctorData;
  late List<UserDoctor> doctors= [];
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];
  Widget _buildSingleCategory(
      {int? index, String? categoryName, IconData? categoryIcon}) {
    return Padding(
      padding: FxSpacing.right(16),
      child: FxCard(
        paddingAll: 8,
        borderRadiusAll: 8,
        bordered: true,
        shadow: FxShadow(
          elevation: 0,
        ),
        //splashColor: AppTheme.customTheme.medicarePrimary.withAlpha(40),
        border: Border.all(
            color: selectedCategory == index
                ? customAppTheme.ktransparent
                : customAppTheme.kBackgroundColor,
            width: 1.5),
        color: selectedCategory == index
            ? customAppTheme.kBackgroundColor
            : customAppTheme.ktransparent,
        onTap: () {
          setState(() {
            selectedCategory = index!;
          });
        },
        child: Row(
          children: [
            FxContainer.rounded(
              child: Icon(
                categoryIcon,
                color: AppTheme.customTheme.medicarePrimary,
                size: 16,
              ),
              color: FxAppTheme.theme.colorScheme.onBackground.withAlpha(16),
              paddingAll: 4,
            ),
            FxSpacing.width(8),
            FxText.caption(
              categoryName!,
              fontWeight: 600,
              color: customAppTheme.colorTextFeed,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = Category.categoryList();
    doctorList = Doctor.doctorList();
  }

  List<Widget> _buildCategoryList() {
    List<Widget> list = [];

    list.add(FxSpacing.width(24));

    for (int i = 0; i < categoryList.length; i++) {
      list.add(_buildSingleCategory(
          index: i,
          categoryName: categoryList[i].category,
          categoryIcon: categoryList[i].categoryIcon));
    }
    return list;
  }

  List<Widget> _buildDoctorList() {
    List<Widget> list = [];

    list.add(FxSpacing.width(16));

    for (int i = 0; i < doctors.length; i++) {
      list.add(_buildSingleDoctor(doctors[i]));
    }
    return list;
  }

  Widget _buildSingleDoctor(UserDoctor doctor) {
    return FxCard(
      onTap: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorPage(doctor: doctor),
          ),
        ); */
      },
      margin: FxSpacing.fromLTRB(24, 0, 24, 16),
      color: customAppTheme.kBackgroundColor,
      paddingAll: 16,
      borderRadiusAll: 16,
      shadow: FxShadow(
        elevation: 0,
      ),
      child: Row(
        children: [
          FxContainer(
            paddingAll: 0,
            borderRadiusAll: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Image(
                width: 72,
                height: 72,
                image: AssetImage("assets/images/avatar_2.jpg"),
              ),
            ),
          ),
          FxSpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.b1(
                  doctor.username,
                  fontWeight: 600,
                  color: customAppTheme.colorTextFeed,
                ),
                FxSpacing.height(4),
                FxText.caption(
                  doctor.hospitals.name,
                  xMuted: true,
                  color: customAppTheme.colorTextFeed,
                ),
                FxSpacing.height(12),
                Row(
                  children: [
                    FxStarRating.buildRatingStar(
                        rating: 4.5, showInactive: true, size: 15),
                    FxSpacing.width(4),
                    FxText.caption(
                      4.5.toString() +
                          ' | ' +
                          120.toString() +
                          ' Reviews',
                      xMuted: true,
                      color: customAppTheme.colorTextFeed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer(builder: ((context, watch, child) {
      final themeProvider = watch(themeNotifierProvider);
      customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
      _doctorData =watch(doctorsControllerDataProvider.state);
      doctors = _doctorData.doctors;
      return Scaffold(
        backgroundColor: customAppTheme.kBackgroundColorFinal,
        body: ListView(
          padding: FxSpacing.top(48),
          children: [
            Padding(
              padding: FxSpacing.horizontal(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxSpacing.width(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FxText.overline(
                        'Current Location',
                        color: customAppTheme.colorTextFeed,
                        xMuted: true,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppTheme.customTheme.medicarePrimary,
                            size: 12,
                          ),
                          FxSpacing.width(4),
                          FxText.caption(
                            'Douala, Cameroon',
                            color: customAppTheme.colorTextFeed,
                            fontWeight: 600,
                          ),
                        ],
                      ),
                    ],
                  ),
                  FxContainer(
                    paddingAll: 4,
                    borderRadiusAll: 4,
                    color: FxAppTheme.customTheme.bgLayer2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Icon(
                          MdiIcons.bell,
                          size: 20,
                          color: FxAppTheme.theme.colorScheme.onBackground
                              .withAlpha(200),
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: FxContainer.rounded(
                            paddingAll: 4,
                            child: Container(),
                            color: AppTheme.customTheme.medicarePrimary,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FxSpacing.height(24),
            Padding(
              padding: FxSpacing.horizontal(24),
              child: FxTextField(
                focusedBorderColor: AppTheme.customTheme.medicarePrimary,
                cursorColor: AppTheme.customTheme.medicarePrimary,
                textFieldStyle: FxTextFieldStyle.outlined,
                labelText: 'Search a doctor or health issue',
                labelStyle: FxTextStyle.caption(
                    color: customAppTheme.colorTextFeed, xMuted: true),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: customAppTheme.kBackgroundColor,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppTheme.customTheme.medicarePrimary,
                  size: 20,
                ),
              ),
            ),
            FxSpacing.height(24),
            GFCarousel(
              items: imageList.map(
                (url) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child:
                          Image.network(url, fit: BoxFit.cover, width: 1000.0),
                    ),
                  );
                },
              ).toList(),
              onPageChanged: (index) {
                setState(() {
                  index;
                });
              },
            ),
            FxSpacing.height(24),
            Padding(
              padding: FxSpacing.horizontal(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.b2(
                    'Upcoming Schedule',
                    color: customAppTheme.colorTextFeed,
                    fontWeight: 700,
                  ),
                  FxText.overline('See all',
                      color: AppTheme.customTheme.medicarePrimary),
                ],
              ),
            ),
            FxSpacing.height(24),
            FxContainer(
              borderRadiusAll: 16,
              margin: FxSpacing.horizontal(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      FxContainer(
                        paddingAll: 0,
                        borderRadiusAll: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image(
                            height: 40,
                            width: 40,
                            image: AssetImage(
                              'assets/images/avatar_3.jpg',
                            ),
                          ),
                        ),
                      ),
                      FxSpacing.width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.caption(
                              'Dr.Haley lawrence',
                              color: AppTheme.customTheme.medicareOnPrimary,
                              fontWeight: 700,
                            ),
                            FxText.overline(
                              'Dermatologists',
                              color: AppTheme.customTheme.medicareOnPrimary
                                  .withAlpha(200),
                            ),
                          ],
                        ),
                      ),
                      FxSpacing.width(16),
                      FxContainer.rounded(
                        paddingAll: 4,
                        child: Icon(
                          Icons.videocam_outlined,
                          color: AppTheme.customTheme.medicarePrimary,
                          size: 16,
                        ),
                        color: AppTheme.customTheme.medicareOnPrimary,
                      ),
                    ],
                  ),
                  FxSpacing.height(16),
                  FxContainer(
                    borderRadiusAll: 8,
                    color:
                        FxAppTheme.theme.colorScheme.onBackground.withAlpha(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.watch_later,
                          color: AppTheme.customTheme.medicareOnPrimary
                              .withAlpha(160),
                          size: 20,
                        ),
                        FxSpacing.width(8),
                        FxText.caption(
                          'Sun, Jan 19, 08:00am - 10:00am',
                          color: AppTheme.customTheme.medicareOnPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              color: AppTheme.customTheme.medicarePrimary,
            ),
            FxSpacing.height(24),
            Padding(
              padding: FxSpacing.horizontal(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.b2(
                    'Let\'s find your doctor',
                    fontWeight: 700,
                    color: customAppTheme.colorTextFeed,
                  ),
                  Icon(
                    Icons.tune_outlined,
                    color: AppTheme.customTheme.medicarePrimary,
                    size: 20,
                  ),
                ],
              ),
            ),
            FxSpacing.height(24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildCategoryList(),
              ),
            ),
            FxSpacing.height(16),
            Column(
              children: _buildDoctorList(),
            ),
          ],
        ),
      );
    }));
  }
}
