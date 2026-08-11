import 'package:flutter/material.dart';
import 'package:product_list_app/screens/home_screen.dart';
import 'package:product_list_app/screens/register_screen.dart';
import 'package:product_list_app/screens/forgot_password_screen.dart';
import 'package:product_list_app/helpers/validators.dart';
import 'package:product_list_app/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String username;

  const LoginScreen({super.key, this.username = ''});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', 'semacsgn');
  }

  late final TextEditingController usernameController;
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.username);
    saveData();
  }

  void login() async {
    final bool isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? savedUsername = prefs.getString('username');

    if (usernameController.text.trim() != savedUsername) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Username is incorrect.')));
      return;
    }

    if (passwordController.text.trim() != '123456') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password is incorrect.')));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void openRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void openForgotPasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOGIN PAGE',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        foregroundColor: Colors.pink,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: usernameController,
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  validator: Validators.validateUsername,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validator: Validators.validatePassword,
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),

                  onFieldSubmitted: (_) {},
                ), // CustomTextField

                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: openForgotPasswordScreen,
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.pink),
                    ),
                    TextButton(
                      onPressed: openRegisterScreen,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
