import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/home_page/models/date_time.dart';
import 'package:sesa/ui/views/home_page/models/slot.dart';
import 'package:sesa/ui/widgets/button/button.dart';
import 'package:sesa/ui/widgets/container/container.dart';

class AppointmentPage extends StatefulWidget {
  AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late int selectedDate = 0;
  late int selectedSlot = 0;

  late List<DateTime> data;
  late List<String> morningSlots;
  late List<String> afternoonSlots;
  late List<String> eveningSlots;
  late CustomAppTheme customAppTheme;

  @override
  initState() {
    super.initState();

    data = DateTime.dummyList();
    morningSlots = Slot.morningList();
    afternoonSlots = Slot.afternoonList();
    eveningSlots = Slot.eveningList();
  }

  List<Widget> _buildDateList() {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(
          _buildSingleDate(date: data[i].date, day: data[i].day, index: i));
    }
    return list;
  }

  List<Widget> _buildMorningSlotList() {
    List<Widget> list = [];
    for (int i = 0; i < morningSlots.length; i++) {
      list.add(_buildSingleSlot(time: morningSlots[i], index: i));
    }
    return list;
  }

  List<Widget> _buildAfternoonSlotList() {
    List<Widget> list = [];
    for (int i = 0; i < afternoonSlots.length; i++) {
      list.add(_buildSingleSlot(
          time: afternoonSlots[i], index: i + morningSlots.length));
    }
    return list;
  }

  List<Widget> _buildEveningSlotList() {
    List<Widget> list = [];
    for (int i = 0; i < eveningSlots.length; i++) {
      list.add(_buildSingleSlot(
          time: eveningSlots[i],
          index: i + morningSlots.length + afternoonSlots.length));
    }
    return list;
  }

  Widget _buildSingleSlot({String? time, int? index}) {
    return InkWell(
        onTap: () {
          setState(() {
            selectedSlot = index!;
          });
        },
        child: FxContainer(
          color: selectedSlot == index
              ? customAppTheme.medicarePrimary
              : customAppTheme.bgLayer2,
          child: Text(
            time!,
            style: FxTextStyle.caption(
                fontWeight: 700,
                color: selectedSlot == index
                    ? customAppTheme.medicareOnPrimary
                    : customAppTheme.colorTextFeed),
          ),
          padding: FxSpacing.symmetric(vertical: 8, horizontal: 16),
          borderRadiusAll: 4,
        ));
  }

  Widget _buildSingleDate({String? date, String? day, int? index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedDate = index!;
        });
      },
      child: FxContainer(
        paddingAll: 12,
        borderRadius: selectedDate == index
            ? BorderRadius.circular(8)
            : BorderRadius.circular(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day!,
              style: FxTextStyle.caption(
                  fontWeight: 800,
                  color: selectedDate == index
                      ? customAppTheme.medicareOnPrimary
                      : customAppTheme.colorTextFeed),
            ),
            FxSpacing.height(12),
            Text(
              date!,
              style: FxTextStyle.caption(
                  fontWeight: 700,
                  color: selectedDate == index
                      ? customAppTheme.medicareOnPrimary
                      : customAppTheme.colorTextFeed),
            ),
          ],
        ),
        color: selectedDate == index
            ? customAppTheme.medicarePrimary
            : Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final themeProvider = watch(themeNotifierProvider);
      customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
      return Scaffold(
        backgroundColor: customAppTheme.kBackgroundColorFinal,
        appBar: AppBar(
          backgroundColor: customAppTheme.kBackgroundColorFinal,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: customAppTheme.colorTextFeed,
              size: 15,
            ),
          ),
          elevation: 0,
          title: Text(
            'Appointment',
            style: FxTextStyle.b1(fontWeight: 700),
          ),
        ),
        body: Container(
          color: customAppTheme.kBackgroundColorFinal,
          child: Column(
            children: [
              Container(
                padding: FxSpacing.nRight(16),
                //color: FxAppTheme.customTheme.bgLayer2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildDateList(),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: FxSpacing.all(24),
                  children: [
                    Text(
                      'Morning Slots',
                      style: FxTextStyle.b2(fontWeight: 800),
                    ),
                    FxSpacing.height(8),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: _buildMorningSlotList(),
                    ),
                    FxSpacing.height(32),
                    Text(
                      'Afternoon Slots',
                      style: FxTextStyle.b2(fontWeight: 800),
                    ),
                    FxSpacing.height(8),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: _buildAfternoonSlotList(),
                    ),
                    FxSpacing.height(32),
                    Text(
                      'Evening Slots',
                      style: FxTextStyle.b2(fontWeight: 800),
                    ),
                    FxSpacing.height(8),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: _buildEveningSlotList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: FxSpacing.all(24),
                child: FxButton.block(
                  borderRadiusAll: 8,
                  onPressed: () {},
                  backgroundColor: AppTheme.customTheme.medicarePrimary,
                  child: Text(
                    "Confirm Appointment",
                    style: FxTextStyle.b2(
                      fontWeight: 700,
                      color: AppTheme.customTheme.medicareOnPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
