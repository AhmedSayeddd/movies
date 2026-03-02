import 'package:flutter/material.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;

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
              _buildTextField(
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                hintText: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password ?',
                    style: AppStyle.summarytext.copyWith(color: const Color(AppColor.gold)),
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
                  Text(
                    "Don't Have Account: ? ",
                    style: AppStyle.summarytext,
                  ),
                  GestureDetector(
                    onTap: () {},
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
                children: [
                  Expanded(child: Divider(color: Color(AppColor.gold), thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('OR', style: TextStyle(color: Color(AppColor.gold))),
                  ),
                  Expanded(child: Divider(color: Color(AppColor.gold), thickness: 1)),
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
                icon: const Icon(Icons.g_mobiledata, color: Color(AppColor.black), size: 30),
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

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword ? _isObscured : false,
      style: AppStyle.summarytext,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.summarytext.copyWith(color: Colors.white70),
        prefixIcon: Icon(prefixIcon, color: const Color(AppColor.white)),
        suffixIcon: isPassword 
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: const Color(AppColor.white),
                ),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFF282A28),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class LanguageToggle extends StatefulWidget {
  final Color activeColor;
  const LanguageToggle({super.key, required this.activeColor});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isEnglish = !isEnglish),
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.activeColor, width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isEnglish ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: widget.activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFlag('assets/images/US.png'),
                _buildFlag('assets/images/EG.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlag(String path) {
    return Image.asset(
      path,
      width: 24,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.flag,
        size: 18,
        color: Colors.white,
      ),
    );
  }
}
