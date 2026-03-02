import 'package:flutter/material.dart';
import '../core/app_assets.dart';
import '../core/app_color.dart';
import '../core/app_style.dart';
import '../model/buildTextField.dart';
import '../model/language_toggle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late PageController _pageController;
  int selectedIndex = 1;

  final List<String> gamerImages = [
    AppAssets.GamerProfile,
    AppAssets.GamerProfile1,
    AppAssets.GamerProfile2,
    AppAssets.GamerProfile3,
    AppAssets.GamerProfile4,
    AppAssets.GamerProfile5,
    AppAssets.GamerProfile6,
    AppAssets.GamerProfile7,
    AppAssets.GamerProfile8,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: selectedIndex,
      viewportFraction: 0.4,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.black),
      appBar: AppBar(
        foregroundColor: const Color(AppColor.gold),
        backgroundColor: const Color(AppColor.black),
        centerTitle: true,
        title: Text(
          "Register",
          style: AppStyle.summarytext.copyWith(color: const Color(AppColor.gold)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: gamerImages.length,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedIndex;

                    return AnimatedScale(
                      scale: isSelected ? 1.2 : 0.7,
                      duration: const Duration(milliseconds: 300),
                      child: Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(gamerImages[index]),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AppTextField(
                  hintText: "Name",
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.identity),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AppTextField(
                  hintText: "Email",
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.email),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AppTextField(
                  hintText: "Password",
                  isPassword: true,
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.password),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AppTextField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.password),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: AppTextField(
                  hintText: "Phone Number",
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.phone),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(AppColor.gold),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: AppStyle.subtitletext.copyWith(
                      color: const Color(AppColor.black),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have Account? ", style: AppStyle.summarytext),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: AppStyle.summarytext.copyWith(
                        color: const Color(AppColor.gold),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const LanguageToggle(activeColor: Color(AppColor.gold)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
