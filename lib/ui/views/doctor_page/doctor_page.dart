import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/appointment_page/appointment_page.dart';
import 'package:sesa/ui/views/chat_page/chat_page.dart';
import 'package:sesa/ui/views/home_page/models/chat.dart';
import 'package:sesa/ui/views/home_page/models/doctor.dart';
import 'package:sesa/ui/widgets/button/button.dart';
import 'package:sesa/ui/widgets/card/card.dart';
import 'package:sesa/ui/widgets/container/container.dart';
import 'package:sesa/ui/widgets/text/text.dart';

class DoctorPage extends StatefulWidget {
  final Doctor doctor;
  DoctorPage({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late CustomAppTheme customAppTheme;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final themeProvider = watch(themeNotifierProvider);
        customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
        return Scaffold(
          backgroundColor: customAppTheme.kBackgroundColorFinal,
          body: ListView(
            padding: FxSpacing.fromLTRB(24, 44, 24, 24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FxContainer(
                      color: customAppTheme.kBackgroundColor,
                      child: Icon(
                        Icons.chevron_left,
                        color: customAppTheme.colorTextFeed.withAlpha(160),
                        size: 24,
                      ),
                      paddingAll: 4,
                      borderRadiusAll: 8,
                    ),
                  ),
                  FxCard.rounded(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            chat: Chat(
                              widget.doctor.image,
                              widget.doctor.name,
                              '',
                              '',
                              '',
                              false,
                            ),
                          ),
                        ),
                      );
                    },
                    color: customAppTheme.kBackgroundColor,
                    child: Icon(
                      MdiIcons.message,
                      color: customAppTheme.colorTextFeed.withAlpha(160),
                      size: 20,
                    ),
                    paddingAll: 8,
                  ),
                ],
              ),
              FxSpacing.height(32),
              Row(
                children: [
                  FxCard(
                    paddingAll: 0,
                    borderRadiusAll: 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Image(
                        fit: BoxFit.cover,
                        height: 160,
                        width: 120,
                        image: AssetImage(widget.doctor.image),
                      ),
                    ),
                  ),
                  FxSpacing.width(24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.b1(
                          widget.doctor.name,
                          fontWeight: 700,
                          fontSize: 18,
                        ),
                        FxSpacing.height(8),
                        FxText.b2(
                          widget.doctor.category,
                          color: customAppTheme.colorTextFeed,
                          xMuted: true,
                        ),
                        FxSpacing.height(12),
                        Row(
                          children: [
                            FxContainer(
                              child: Icon(
                                Icons.star_rounded,
                                color: AppTheme.customTheme.colorWarning,
                              ),
                              paddingAll: 8,
                              color: customAppTheme.kBackgroundColor,
                            ),
                            FxSpacing.width(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.caption(
                                  'Rating',
                                  color: customAppTheme.colorTextFeed,
                                  xMuted: true,
                                ),
                                FxSpacing.height(2),
                                FxText.caption(
                                  widget.doctor.ratings.toString() +
                                      ' out of 5',
                                  color: customAppTheme.colorTextFeed,
                                  fontWeight: 700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        FxSpacing.height(8),
                        Row(
                          children: [
                            FxContainer(
                              color: customAppTheme.kBackgroundColor,
                              child: Icon(
                                Icons.group,
                                color: AppTheme.customTheme.blue,
                              ),
                              paddingAll: 8,
                            ),
                            FxSpacing.width(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.caption(
                                  'Patients',
                                  color: customAppTheme.colorTextFeed,
                                  xMuted: true,
                                ),
                                FxSpacing.height(2),
                                FxText.caption(
                                  widget.doctor.patients.toString() + '+',
                                  color: customAppTheme.colorTextFeed,
                                  fontWeight: 700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FxSpacing.height(32),
              FxContainer(
                color: customAppTheme.kBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.b1(
                      'Biography',
                      fontWeight: 600,
                    ),
                    FxSpacing.height(16),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: widget.doctor.biography,
                          style: FxTextStyle.caption(
                            color: customAppTheme.colorTextFeed,
                            xMuted: true,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: " Read more",
                          style: FxTextStyle.caption(
                            color: customAppTheme.blue,
                          ),
                        ),
                      ]),
                    ),
                    FxSpacing.height(24),
                    FxText.b1(
                      'Location',
                      fontWeight: 600,
                    ),
                    FxSpacing.height(16),
                    FxContainer(
                      paddingAll: 0,
                      borderRadiusAll: 16,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image(
                          fit: BoxFit.cover,
                          height: 140,
                          width: MediaQuery.of(context).size.width - 96,
                          image: AssetImage('assets/images/map-md-snap.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                paddingAll: 10,
                borderRadiusAll: 16,
              ),
              FxSpacing.height(32),
              FxButton.block(
                elevation: 0,
                borderRadiusAll: 8,
                backgroundColor: AppTheme.customTheme.medicarePrimary,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentPage()));
                },
                child: FxText.b1(
                  'Make Appointment',
                  color: AppTheme.customTheme.medicareOnPrimary,
                  fontWeight: 600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
