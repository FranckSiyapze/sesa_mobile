import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/text_utils.dart';
import 'package:sesa/ui/utils/themes/custom_app_theme.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/utils/themes/theme_provider.dart';
import 'package:sesa/ui/views/ecommerce_page/checkout_page.dart';
import 'package:sesa/ui/views/ecommerce_page/models/cart.dart';
import 'package:sesa/ui/widgets/button/button.dart';
import 'package:sesa/ui/widgets/container/container.dart';
import 'package:sesa/ui/widgets/dash_divider/dash_divider.dart';
import 'package:sesa/ui/widgets/generator.dart';
import 'package:sesa/ui/widgets/text/text.dart';
import 'package:sesa/ui/widgets/text_field/text_field.dart';

class CartPage extends StatefulWidget {
  final BuildContext rootContext;

  const CartPage({Key? key, required this.rootContext}) : super(key: key);

  @override
  _GroceryCartScreenState createState() => _GroceryCartScreenState();
}

class _GroceryCartScreenState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late List<Cart> carts;

  late CustomAppTheme customAppTheme;
  @override
  initState() {
    super.initState();
    carts = Cart.getList();
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final themeProvider = watch(themeNotifierProvider);
      customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppTheme.customTheme.groceryBg1,
            title: FxText.h6("Cart", fontWeight: 600),
          ),
          backgroundColor: AppTheme.customTheme.groceryBg1,
          body: ListView(
            padding: FxSpacing.fromLTRB(24, 8, 24, 70),
            children: <Widget>[
              Column(
                children: buildCarts(),
              ),
              FxSpacing.height(16),
              FxContainer(
                color: AppTheme.customTheme.groceryBg2,
                padding: FxSpacing.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: FxTextField(
                        hintText: "Promo Code",
                        hintStyle: FxTextStyle.b2(),
                        labelStyle: FxTextStyle.b2(),
                        style: FxTextStyle.b2(),
                        labelText: "Promo Code",
                        isDense: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: FxSpacing.right(16),
                        focusedBorderColor: Colors.transparent,
                        cursorColor: AppTheme.customTheme.groceryPrimary,
                        prefixIcon: Icon(
                          MdiIcons.ticketPercentOutline,
                          size: 22,
                          color: customAppTheme.colorTextFeed.withAlpha(150),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    FxButton.medium(
                      onPressed: () {
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroceryCouponScreen())); */
                      },
                      child: FxText.button("Find",
                          letterSpacing: 0.5,
                          fontWeight: 600,
                          color: AppTheme.customTheme.groceryOnPrimary),
                      backgroundColor: AppTheme.customTheme.groceryPrimary,
                      borderRadiusAll: 4,
                      padding: FxSpacing.xy(32, 12),
                    ),
                  ],
                ),
              ),
              FxSpacing.height(16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.b2("Subtotal", fontWeight: 600),
                      FxText.b2("\$86.50",
                          letterSpacing: 0.25, fontWeight: 600),
                    ],
                  ),
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.b2("Delivery", fontWeight: 600),
                      FxText.b2("\$18.50",
                          letterSpacing: 0.25, fontWeight: 600),
                    ],
                  ),
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.b2("Tax & Fee", fontWeight: 600),
                      FxText.b2("\$9.99", letterSpacing: 0.25, fontWeight: 600),
                    ],
                  ),
                  FxSpacing.height(12),
                  FxDashedDivider(
                    dashSpace: 6,
                    height: 1.2,
                    dashWidth: 8,
                    color: customAppTheme.colorTextFeed,
                  ),
                  FxSpacing.height(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.b1("Total", fontWeight: 700),
                      FxText.b1("\$99.50",
                          letterSpacing: 0.25, fontWeight: 700),
                    ],
                  ),
                ],
              ),
              FxSpacing.height(24),
              Center(
                child: FxButton.medium(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(),
                      ),
                    );
                  },
                  child: FxText.button(
                    "CHECKOUT",
                    letterSpacing: 0.5,
                    fontWeight: 600,
                    color: AppTheme.customTheme.groceryOnPrimary,
                  ),
                  backgroundColor: AppTheme.customTheme.groceryPrimary,
                  borderRadiusAll: 4,
                  padding: FxSpacing.xy(32, 12),
                  elevation: 2,
                ),
              )
            ],
          ));
    });
  }

  List<Widget> buildCarts() {
    List<Widget> list = [];

    for (int i = 0; i < carts.length; i++) {
      list.add(SingleCartWidget(context, carts[i]));
      if (i + 1 < carts.length) list.add(FxSpacing.height(16));
    }

    return list;
  }
}

class SingleCartWidget extends StatefulWidget {
  final BuildContext rootContext;
  final Cart cart;

  const SingleCartWidget(this.rootContext, this.cart);

  @override
  _SingleCartWidgetState createState() => _SingleCartWidgetState();
}

class _SingleCartWidgetState extends State<SingleCartWidget> {
  late int quantity;
  late BuildContext rootContext;

  String? heroKey;

  @override
  void initState() {
    super.initState();
    quantity = widget.cart.quantity;
    rootContext = widget.rootContext;
    heroKey = Generator.getRandomString(10);
  }

  late CustomAppTheme customAppTheme;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final themeProvider = watch(themeNotifierProvider);
        customAppTheme = AppTheme.getCustomAppTheme(themeProvider.themeMode());
        return Container(
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: AppTheme.customTheme.groceryBg1,
            ),
            secondaryBackground: Container(
              color: AppTheme.customTheme.groceryBg1,
              padding: FxSpacing.horizontal(20),
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: FxSpacing.right(8),
                    padding: FxSpacing.all(16),
                    decoration: BoxDecoration(
                        color: AppTheme.customTheme.red.withAlpha(40),
                        shape: BoxShape.circle),
                    child: Icon(
                      MdiIcons.delete,
                      size: 22,
                      color: AppTheme.customTheme.red,
                    ),
                  ),
                ],
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  //TODO: perform delete operation
                });
              }
            },
            child: FxContainer(
              color: AppTheme.customTheme.groceryBg2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxContainer(
                    color: AppTheme.customTheme.groceryPrimary.withAlpha(32),
                    padding: FxSpacing.all(8),
                    child: Hero(
                      tag: heroKey!,
                      child: ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          widget.cart.image,
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
                        FxText.b1(widget.cart.name, fontWeight: 600),
                        FxSpacing.height(8),
                        widget.cart.discountedPrice != widget.cart.price
                            ? Row(
                                children: [
                                  FxText.caption(
                                      FxTextUtils.doubleToString(
                                              widget.cart.price) +
                                          " FCFA",
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: 500),
                                  // Space.width(8),
                                  FxSpacing.width(8),
                                  FxText.b2(
                                      FxTextUtils.doubleToString(
                                              widget.cart.discountedPrice) +
                                          " FCFA",
                                      color: customAppTheme.colorTextFeed,
                                      fontWeight: 700),
                                ],
                              )
                            : FxText.b2(
                                FxTextUtils.doubleToString(widget.cart.price) +
                                    " FCFA",
                                color: customAppTheme.colorTextFeed,
                                fontWeight: 700),
                        FxSpacing.height(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FxContainer(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                              paddingAll: 8,
                              borderRadiusAll: 4,
                              color: AppTheme.customTheme.groceryPrimary
                                  .withAlpha(48),
                              child: Icon(
                                MdiIcons.minus,
                                size: 14,
                                color: AppTheme.customTheme.groceryPrimary,
                              ),
                            ),
                            FxSpacing.width(12),
                            FxText.b1(quantity.toString(), fontWeight: 600),
                            FxSpacing.width(12),
                            FxContainer(
                              padding: FxSpacing.all(8),
                              borderRadiusAll: 4,
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              color: AppTheme.customTheme.groceryPrimary,
                              child: Icon(
                                MdiIcons.plus,
                                size: 14,
                                color: AppTheme.customTheme.groceryOnPrimary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
