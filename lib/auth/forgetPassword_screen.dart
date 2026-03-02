import 'package:flutter/material.dart';
import 'package:movies/core/app_assets.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';
import '../model/buildTextField.dart';

class ForgetpasswordScreen extends StatelessWidget {
  const ForgetpasswordScreen({super.key});

  static const String routeName = "ForgetpasswordScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.black),
      appBar: AppBar(
        foregroundColor: const Color(AppColor.gold),
        backgroundColor: const Color(AppColor.black),
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: AppStyle.summarytext.copyWith(color: const Color(AppColor.gold)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(AppAssets.forgotPassword),
            const SizedBox(height: 24),
            const AppTextField(
              hintText: "Email",
              prefixIcon: ImageIcon(
                AssetImage(AppAssets.email),
                size: 24,
                color: Color(AppColor.white),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(AppColor.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Verify Email",
                  style: AppStyle.tex.copyWith(color: const Color(AppColor.black)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
