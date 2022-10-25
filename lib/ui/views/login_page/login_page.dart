import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:sesa/core/services/api_service.dart';
import 'package:sesa/main.dart';
import 'package:sesa/ui/utils/colors.dart';
import 'package:sesa/ui/utils/spacing.dart';
import 'package:sesa/ui/utils/storage.dart';
import 'package:sesa/ui/utils/themes/text_style.dart';
import 'package:sesa/ui/views/login_page/otp_page.dart';
import 'package:sesa/ui/views/main_page.dart';
import 'package:sesa/ui/widgets/button/button.dart';
import 'package:sesa/ui/widgets/text/text.dart';
import 'package:sesa/ui/widgets/text_field/text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiService _apiService = ApiService();
  TextEditingController email = TextEditingController(text: "franck");
  TextEditingController pwd = TextEditingController(text: "Popin@2009");
  bool signIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: FxSpacing.horizontal(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/logo_dark.png'),
                  ),
                ),
              ),
              FxSpacing.height(24),
              FxTextField(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                controller: email,
                autoFocusedBorder: true,
                textFieldStyle: FxTextFieldStyle.outlined,
                textFieldType: FxTextFieldType.email,
                filled: true,
                fillColor: kPrimary.withAlpha(50),
                enabledBorderColor: kPrimary,
                focusedBorderColor: kPrimary,
                prefixIconColor: kPrimary,
                labelTextColor: kPrimary,
                cursorColor: kPrimary,
              ),
              FxSpacing.height(24),
              FxTextField(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                controller: pwd,
                autoFocusedBorder: true,
                textFieldStyle: FxTextFieldStyle.outlined,
                textFieldType: FxTextFieldType.password,
                filled: true,
                fillColor: kPrimary.withAlpha(50),
                enabledBorderColor: kPrimary,
                focusedBorderColor: kPrimary,
                prefixIconColor: kPrimary,
                labelTextColor: kPrimary,
                cursorColor: kPrimary,
              ),
              FxSpacing.height(16),
              Align(
                alignment: Alignment.centerRight,
                child: FxButton.text(
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MediCareForgotPasswordScreen()),
                      ); */
                    },
                    splashColor: kPrimary.withAlpha(40),
                    child: Text(
                      "Forgot Password?",
                      style: FxTextStyle.caption(color: kPrimary),
                    )),
              ),
              FxSpacing.height(16),
              !signIn
                  ? FxButton.block(
                      borderRadiusAll: 8,
                      onPressed: () {
                        /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OTPPage()),
                  ); */
                        setState(() {
                          signIn = true;
                        });
                        _apiService
                            .login(email: email.text, pwd: pwd.text)
                            .then((value) {
                          if (value["status"] == 200) {
                            setState(() {
                              signIn = false;
                            });
                            setStorage("loginstatus", "loggedin");
                            setStorage("bearer", value["data"]["bearerToken"]);
                            setStorage("refreshToken", value["data"]["refreshToken"]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                          } else {
                            setState(() {
                              signIn = false;
                            });
                            Fluttertoast.showToast(
                              msg: "Une erreur est surevenue !",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 5,
                              backgroundColor: kRedColor,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        });
                      },
                      backgroundColor: kPrimary,
                      child: FxText.sh2(
                        "LOG IN",
                        fontWeight: 700,
                        color: KWhite,
                        letterSpacing: 0.4,
                      ),
                    )
                  : CircularProgressIndicator(
                      color: kPrimary,
                    ),
              FxSpacing.height(16),
              FxButton.text(
                onPressed: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MediCareRegistrationScreen()),
                  ); */
                },
                splashColor: kPrimary.withAlpha(40),
                child: FxText.button("I haven\'t an account",
                    decoration: TextDecoration.underline, color: kPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
