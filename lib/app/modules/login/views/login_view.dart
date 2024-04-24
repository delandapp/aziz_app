import 'package:easylibrary/app/data/constans/validation.dart';
import 'package:easylibrary/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

import 'package:google_fonts/google_fonts.dart';

extension CustomValidationBuilder on ValidationBuilder {
  custom() => add((value) {
        if (!EmailValidator.isValidEmail(value)) {
          return 'Enter a valid email address with @smk.belajar.id';
        }
        return null;
      });
  password() => add((value) {
        if (!PasswordValidator.isValidPasswordUpper(password: value)) {
          return 'Password must contain at least 1 uppercase letter';
        }
        if (!PasswordValidator.isValidPasswordSymbol(password: value)) {
          return 'Password must contain at least 1 Sysmbol';
        }
        return null;
      });
  ValidationBuilder confirmPassword(TextEditingController controller) {
    return this
      ..add((value) {
        if (value != controller.text.toString()) {
          return 'Passwords do not match';
        }
        return null;
      });
  }
}

final validatorPassword = ValidationBuilder()
    .minLength(8, 'Password must be at least 8 characters')
    .password()
    .build();
final validator = ValidationBuilder().email().custom().build();

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: Form(
          key: controller.formKey,
          child: Container(
            padding: EdgeInsets.all(5),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login.png'), fit: BoxFit.fill)),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to \n Easy Library APP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GoogleFonts.readexPro().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                    Image(image: AssetImage('assets/images/logo.png'), width: 150),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(0.0),
                    //   constraints:
                    //       BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [Color(0xff4E01F2), Color(0xffAF2FBA)],
                    //         begin: Alignment.topCenter,
                    //         end: Alignment.bottomCenter,
                    //       ),
                    //       borderRadius: BorderRadius.circular(30.0)),
                    //   child: Text(
                    //     "Login",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontFamily: GoogleFonts.poppins().fontFamily,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 20),
                    //   ),
                    // ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.email,
                              validator: validator,
                              autocorrect: false,
                              autofocus: true,
                              enableInteractiveSelection: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                label: Text('Email'),
                                floatingLabelStyle: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[700]),
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                // border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 3)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              )),
                          SizedBox(height: 30),
                          Obx(
                            () => TextFormField(
                                validator: validatorPassword,
                                controller: controller.password,
                                obscureText: controller.isObsure.value,
                                autocorrect: false,
                                autofocus: true,
                                enableInteractiveSelection: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                                decoration: InputDecoration(
                                  suffixIcon: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.isObsure.value =
                                              !controller.isObsure.value;
                                        },
                                        child: FaIcon(
                                          (controller.isObsure.value) == true
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  hintText: 'Surakarta124@',
                                  label: Text('Password'),
                                  floatingLabelStyle: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700]),
                                  labelStyle: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3)),
                                  // border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 3)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                )),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text('Belum memiliki akun?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily)),
                              TextButton(
                                  child: Text('Register',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade300)),
                                  onPressed: () {
                                    Get.toNamed(Routes.REGISTER);
                                  },
                                  style: ButtonStyle(
                                      minimumSize:
                                          MaterialStatePropertyAll(Size(0, 0)),
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.all(2)))),
                            ],
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          controller.login();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff4E01F2), Color(0xffAF2FBA)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: controller.loading.value
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
