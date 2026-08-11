import 'package:flutter/material.dart';
import 'package:product_list_app/helpers/validators.dart';
import 'package:product_list_app/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> mailKey = GlobalKey<FormState>();
  final TextEditingController emailController =
      TextEditingController();

  Future<void> sendResetLink() async {
    final bool isMailValid =
        mailKey.currentState?.validate() ?? false;

    if (!isMailValid) {
      return;
    }

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password reset link has been sent.',
        ),
        duration: Duration(seconds: 2),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password '),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: mailKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Input your email',
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: sendResetLink,
                    child: const Text(
                      'Send Reset Link',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}