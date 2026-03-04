import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_color.dart';
import '../../core/app_style.dart';
import '../../model/buildTextField.dart';
import '../../model/language_toggle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late PageController _pageController;
  int selectedIndex = 1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
              'name': _nameController.text.trim(),
              'email': _emailController.text.trim(),
              'phone': _phoneController.text.trim(),
              'avatarIndex': selectedIndex,
              'uid': userCredential.user!.uid,
            });

        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
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
          style: AppStyle.summarytext.copyWith(
            color: const Color(AppColor.gold),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: AppTextField(
                    controller: _nameController,
                    hintText: "Name",
                    prefixIcon: const ImageIcon(
                      AssetImage(AppAssets.identity),
                      size: 24,
                      color: Color(AppColor.white),
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? "Name Required"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: AppTextField(
                    controller: _emailController,
                    hintText: "Email",
                    prefixIcon: const ImageIcon(
                      AssetImage(AppAssets.email),
                      size: 24,
                      color: Color(AppColor.white),
                    ),
                    validator: (value) =>
                        (value == null || !value.contains('@'))
                        ? "Invalid Email"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: AppTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    isPassword: true,
                    prefixIcon: const ImageIcon(
                      AssetImage(AppAssets.password),
                      size: 24,
                      color: Color(AppColor.white),
                    ),
                    validator: (value) => (value == null || value.length < 6)
                        ? "Too Short"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: AppTextField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    isPassword: true,
                    prefixIcon: const ImageIcon(
                      AssetImage(AppAssets.password),
                      size: 24,
                      color: Color(AppColor.white),
                    ),
                    validator: (value) => (value != _passwordController.text)
                        ? "Not Match"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: AppTextField(
                    controller: _phoneController,
                    hintText: "Phone Number",
                    prefixIcon: const ImageIcon(
                      AssetImage(AppAssets.phone),
                      size: 24,
                      color: Color(AppColor.white),
                    ),
                    validator: (value) => (value == null || value.length < 10)
                        ? "Invalid Phone"
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: _register,
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
      ),
    );
  }
}
