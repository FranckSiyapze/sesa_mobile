import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sesa/ui/utils/colors.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/ecommerce_page/cart_page.dart';
import 'package:sesa/ui/views/ecommerce_page/models/product.dart';
import 'package:sesa/ui/views/ecommerce_page/product_page.dart';
import 'package:sesa/ui/widgets/container/container.dart';
import 'package:sesa/ui/widgets/generator.dart';
import 'package:sesa/ui/widgets/text/text.dart';
import 'package:sesa/ui/widgets/widget.dart';

class EcommercePage extends StatefulWidget {
  final BuildContext rootContext;
  EcommercePage({Key? key, required this.rootContext}) : super(key: key);

  @override
  State<EcommercePage> createState() => _EcommercePageState();
}

class _EcommercePageState extends State<EcommercePage> {
  late CustomAppTheme customAppTheme;

  List<Widget> buildCategories() {
    List<Widget> list = [];
    list.add(FxSpacing.width(24));
    for (int i = 0; i < 7; i++) {
      list.add(getSingleCategory());
      list.add(FxSpacing.width(16));
    }
    return list;
  }

  List<Widget> buildProducts() {
    List<Widget> list = [];
    for (int i = 0; i < 7; i++) {
      list.add(getSingleProduct());
      list.add(FxSpacing.height(5));
    }
    return list;
  }

  Widget getSingleCategory() {
    String heroTag = Generator.getRandomString(10);

    return Hero(
      tag: heroTag,
      child: Material(
        color: customAppTheme.kVioletColor.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            /* Navigator.push(
                rootContext,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => SingleCategoryPage(
                    heroKey: heroTag,
                    rootContext: context,
                    category: category,
                  ),
                ),
              ); */
          },
          child: Container(
            padding: FxSpacing.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / 40,
              top: MediaQuery.of(context).size.height / 110,
              bottom: MediaQuery.of(context).size.height / 110,
            ),
            decoration: BoxDecoration(
              color: customAppTheme.kVioletColor.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
            ),
            width: MediaQuery.of(context).size.width / 5,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/strawberry.png",
                  width: 28,
                  height: 28,
                ),
                FxSpacing.height(4),
                FxText.overline(
                  "Fruit",
                  color: customAppTheme.colorTextFeed,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSingleProduct() {
    String heroKey = Generator.getRandomString(10);

    return InkWell(
      onTap: () {
        Navigator.push(
          widget.rootContext,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => ProductPage(
              product: Product.getList()[0],
              heroKey: heroKey,
            ),
          ),
        );
      },
      child: FxContainer(
        margin: FxSpacing.bottom(16),
        color: AppTheme.customTheme.groceryBg2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              color: AppTheme.customTheme.groceryPrimary.withAlpha(32),
              padding: FxSpacing.all(8),
              child: Hero(
                tag: heroKey,
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    "assets/images/product_2.png",
                    width: 72,
                    height: 72,
                  ),
                ),
              ),
            ),
            FxSpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.b2(
                    "Orange Fresh Juice",
                    color: customAppTheme.colorTextFeed,
                    fontWeight: 600,
                  ),
                  FxSpacing.height(8),
                  FxText.overline(
                    Generator.getDummyText(8),
                    color: customAppTheme.colorTextFeed,
                    muted: true,
                  ),
                  FxSpacing.height(8),
                  Row(
                    children: [
                      FxText.caption(
                        "3000 FCFA",
                        decoration: TextDecoration.lineThrough,
                        fontWeight: 300,
                        color: customAppTheme.colorTextFeed,
                      ),
                      // Space.width(8),
                      FxSpacing.width(8),
                      FxText.b2(
                        "2000 FCFA",
                        color: customAppTheme.colorTextFeed,
                        fontWeight: 700,
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Space.width(8),
            Icon(
              MdiIcons.heartOutline,
              color: AppTheme.customTheme.groceryPrimary,
              size: 18,
            )
          ],
        ),
      ),
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
              padding: FxSpacing.fromLTRB(0, 48, 0, 70),
              children: [
                Padding(
                  padding: FxSpacing.horizontal(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.h6(
                        "Hi, Franck!",
                        fontWeight: 600,
                        color: customAppTheme.colorTextFeed,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                rootContext: widget.rootContext,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              MdiIcons.cartOutline,
                              size: 22,
                              color: customAppTheme.blackColor,
                            ),
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                padding: FxSpacing.zero,
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  color: kRedColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                ),
                                child: Center(
                                  child: FxText.overline(
                                    "3",
                                    color: customAppTheme.kWhite,
                                    fontSize: 8,
                                    fontWeight: 500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                FxSpacing.height(8),
                Padding(
                  padding: FxSpacing.horizontal(24),
                  child: FxText.b2(
                    "What would you buy today?",
                    color: customAppTheme.colorTextFeed,
                    fontWeight: 500,
                    xMuted: true,
                  ),
                ),
                FxSpacing.height(24),
                getBannerWidget(context: context),
                FxSpacing.height(24),
                Padding(
                  padding: FxSpacing.horizontal(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.sh1(
                        "Categories",
                        letterSpacing: 0,
                        color: customAppTheme.colorTextFeed,
                        fontWeight: 600,
                      ),
                      FxText.caption(
                        "See All",
                        color: customAppTheme.colorTextFeed,
                        fontWeight: 600,
                        xMuted: true,
                        letterSpacing: 0,
                      ),
                    ],
                  ),
                ),
                FxSpacing.height(16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buildCategories(),
                  ),
                ),
                FxSpacing.height(24),
                Padding(
                  padding: FxSpacing.horizontal(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.sh1(
                        "Best Selling",
                        color: customAppTheme.colorTextFeed,
                        fontWeight: 600,
                      ),
                      FxText.caption(
                        "See All",
                        color: customAppTheme.colorTextFeed,
                        fontWeight: 600,
                        xMuted: true,
                        letterSpacing: 0,
                      ),
                    ],
                  ),
                ),
                FxSpacing.height(16),
                Padding(
                  padding: FxSpacing.horizontal(24),
                  child: Column(
                    children: buildProducts(),
                  ),
                )
              ],
            ));
      },
    );
  }
}
