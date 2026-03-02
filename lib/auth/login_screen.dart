import 'package:flutter/material.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/core/app_assets.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';

import '../model/buildTextField.dart';
import '../model/language_toggle.dart';
import 'forgetPassword_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.black),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/logo.png',
                height: 190,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.play_circle_fill,
                  color: Color(AppColor.gold),
                  size: 100,
                ),
              ),
              const SizedBox(height: 40),
              const AppTextField(
                hintText: 'Email',
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.email),
                  size: 24,
                  color: Color(AppColor.white),
                ),
              ),
              const SizedBox(height: 20),
              const AppTextField(
                hintText: 'Password',
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.password),
                  size: 24,
                  color: Color(AppColor.white),
                ),
                isPassword: true,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetpasswordScreen.routeName);
                  },
                  child: Text(
                    'Forget Password ?',
                    style: AppStyle.summarytext.copyWith(
                      color: const Color(AppColor.gold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(AppColor.gold),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Login',
                  style: AppStyle.subtitletext.copyWith(
                    color: const Color(AppColor.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have Account: ? ", style: AppStyle.summarytext),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      'Create One',
                      style: AppStyle.summarytext.copyWith(
                        color: const Color(AppColor.gold),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 91,
                      child: Divider(color: Color(AppColor.gold), thickness: 0.5)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Color(AppColor.gold)),
                    ),
                  ),
                  SizedBox(
                      width: 91,
                      child: Divider(color: Color(AppColor.gold), thickness: 0.5)),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(AppColor.gold),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const ImageIcon(
                  AssetImage(AppAssets.google),
                  size: 25,
                ),
                label: Text(
                  'Login With Google',
                  style: AppStyle.subtitletext.copyWith(
                    color: const Color(AppColor.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const LanguageToggle(activeColor: Color(AppColor.gold)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
