import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/auth/data/auth_repo.dart';
import 'package:movies/auth/screens/register_screen.dart';
import 'package:movies/core/app_assets.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';
import '../../model/buildTextField.dart';
import '../../model/language_toggle.dart';
import 'forgetPassword_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // 👈 instantiate AuthService

  bool _isGoogleLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null && mounted) {
        Navigator.pop(context); // or Navigator.pushReplacementNamed to your home route
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.black),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: (value) => (value == null || !value.contains('@'))
                      ? "Invalid Email"
                      : null,
                  prefixIcon: const ImageIcon(
                    AssetImage(AppAssets.email),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) =>
                      (value == null || value.length < 6) ? "Too Short" : null,
                  prefixIcon: const ImageIcon(
                    AssetImage(AppAssets.password),
                    size: 24,
                    color: Color(AppColor.white),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgetpasswordScreen.routeName,
                      );
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
                  onPressed: _login,
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
                      child: Divider(
                        color: Color(AppColor.gold),
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Color(AppColor.gold)),
                      ),
                    ),
                    SizedBox(
                      width: 91,
                      child: Divider(
                        color: Color(AppColor.gold),
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // 👇 Google Sign-In button with loading state
                ElevatedButton.icon(
                  onPressed: _isGoogleLoading ? null : _loginWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(AppColor.gold),
                    disabledBackgroundColor:
                        const Color(AppColor.gold).withOpacity(0.6),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  icon: _isGoogleLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.black,
                          ),
                        )
                      : const ImageIcon(AssetImage(AppAssets.google), size: 25),
                  label: Text(
                    _isGoogleLoading ? 'Signing in...' : 'Login With Google',
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
      ),
    );
  }
}
