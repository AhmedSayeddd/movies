import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_assets.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';
import '../../model/buildTextField.dart';

class ForgetpasswordScreen extends StatefulWidget {
  const ForgetpasswordScreen({super.key});

  static const String routeName = "ForgetpasswordScreen";

  @override
  State<ForgetpasswordScreen> createState() => _ForgetpasswordScreenState();
}

class _ForgetpasswordScreenState extends State<ForgetpasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false; // shows success UI after sending

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          _emailSent = true; // switch to success state
        });
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar(_mapError(e.code));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Something went wrong. Please try again.');
      }
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return 'Failed to send reset email. Please try again.';
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
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
          "Forget Password",
          style: AppStyle.summarytext.copyWith(
            color: const Color(AppColor.gold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _emailSent ? _buildSuccessState() : _buildFormState(),
      ),
    );
  }

  Widget _buildFormState() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset(AppAssets.forgotPassword),
          const SizedBox(height: 8),
          Text(
            'Enter your email and we\'ll send you a link to reset your password.',
            textAlign: TextAlign.center,
            style: AppStyle.summarytext.copyWith(
              color: const Color(AppColor.white).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: _emailController,
            hintText: "Email",
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return 'Email is required';
              if (!value.contains('@') || !value.contains('.'))
                return 'Enter a valid email';
              return null;
            },
            prefixIcon: const ImageIcon(
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
              onPressed: _isLoading ? null : _sendResetEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(AppColor.gold),
                disabledBackgroundColor: const Color(
                  AppColor.gold,
                ).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.black,
                      ),
                    )
                  : Text(
                      "Verify Email",
                      style: AppStyle.tex.copyWith(
                        color: const Color(AppColor.black),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Icon(
          Icons.mark_email_read_outlined,
          size: 90,
          color: Color(AppColor.gold),
        ),
        const SizedBox(height: 24),
        Text(
          'Reset Link Sent!',
          style: AppStyle.summarytext.copyWith(
            color: const Color(AppColor.gold),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'We sent a password reset link to:\n${_emailController.text.trim()}',
          textAlign: TextAlign.center,
          style: AppStyle.summarytext.copyWith(
            color: const Color(AppColor.white).withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 32),

        // Resend button
        TextButton(
          onPressed: () => setState(() => _emailSent = false),
          child: Text(
            "Didn't receive it? Try again",
            style: AppStyle.summarytext.copyWith(
              color: const Color(AppColor.gold),
              decoration: TextDecoration.underline,
              decorationColor: const Color(AppColor.gold),
            ),
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppColor.gold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              "Back to Login",
              style: AppStyle.tex.copyWith(color: const Color(AppColor.black)),
            ),
          ),
        ),
      ],
    );
  }
}
