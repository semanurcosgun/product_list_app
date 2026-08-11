import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_list_app/screens/login_screen.dart';
import 'package:product_list_app/helpers/validators.dart';
import 'package:product_list_app/widgets/custom_text_field.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> personalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> accountKey = GlobalKey<FormState>(); 

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController birthDateController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController againPasswordController = TextEditingController();

  int currentStep = 0;

  bool notificationsEnabled = false;
  bool acceptedTerms = false;
  bool acceptEmail = false;

  bool obscurePassword = true;
  bool obscureAgainPassword = true;

  String? selectedGender;
  String? genderError;
  String? termsError;

  bool validatePreferences() {
    final bool isGenderValid = selectedGender != null;
    final bool isTermsValid = acceptedTerms;

    setState(() {
      genderError = isGenderValid ? null : 'Lütfen cinsiyet seçiniz';

      termsError = isTermsValid
          ? null
          : 'Kullanim koşullarini kabul etmelisiniz';
    });

    return isGenderValid && isTermsValid;
  }

  Future<void> selectBirthDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    birthDateController.text =
        '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  void continueStep() {
    if (currentStep == 0) {
      final bool isPersonalValid =
          personalKey.currentState?.validate() ?? false;

      if (isPersonalValid) {
        setState(() {
          currentStep = 1;
        });
      }

      return;
    }

    if (currentStep == 1) {
      final bool isAccountValid = accountKey.currentState?.validate() ?? false;

      if (isAccountValid) {
        setState(() {
          currentStep = 2;
        });
      }

      return;
    }

    completeRegistration();
  }

  void completeRegistration() {
    final bool isPersonalValid = personalKey.currentState?.validate() ?? false;

    final bool isAccountValid = accountKey.currentState?.validate() ?? false;

    final bool isPreferencesValid = validatePreferences();

    if (!isPersonalValid || !isAccountValid || !isPreferencesValid) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registration successful.')));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginScreen(username: usernameController.text.trim()),
      ),
    );
  }

  void cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  List<Step> get stepperSteps {
    return [
      Step(
        title: const Text('Personal Information'),
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        content: Form(
          key: personalKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Your Full Name',
                controller: fullNameController,
                validator: Validators.validateFullName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Call Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validators.validatePhone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Birth Date',
                controller: birthDateController,
                readOnly: true,
                onTap: selectBirthDate,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                validator: Validators.validateBirthDate,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Account Information'),
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        content: Form(
          key: accountKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Username',
                controller: usernameController,
                validator: Validators.validateUsername,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: obscurePassword,
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
                  validator: Validators.validatePassword,
                textInputAction: TextInputAction.next,
                ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Password Again',
                controller: againPasswordController,
                obscureText: obscureAgainPassword,
                decoration: InputDecoration(
                  labelText: 'Password Again',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureAgainPassword = !obscureAgainPassword;
                      });
                    },
                    icon: Icon(
                      obscureAgainPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) => Validators.validateAgainPassword(
                  value,
                  passwordController.text,
                ),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Done'),
        isActive: currentStep >= 2,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu<String>(
              width: double.infinity,
              label: const Text('Select your gender'),
              initialSelection: selectedGender,
              dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                DropdownMenuEntry<String>(value: 'Female', label: 'Female'),
                DropdownMenuEntry<String>(value: 'Male', label: 'Male'),
                DropdownMenuEntry<String>(
                  value: 'Prefer not to say',
                  label: 'Prefer not to say',
                ),
              ],
              onSelected: (String? value) {
                setState(() {
                  selectedGender = value;
                  genderError = null;
                });
              },
            ),
            if (genderError != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  genderError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
              title: const Text('Enable Notifications'),
              secondary: const Icon(Icons.notifications_outlined),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: acceptedTerms,
              onChanged: (bool? value) {
                setState(() {
                  acceptedTerms = value ?? false;

                  if (acceptedTerms) {
                    termsError = null;
                  }
                });
              },
              title: const Text('I accept the terms and conditions'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (termsError != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  termsError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: acceptEmail,
              onChanged: (bool? value) {
                setState(() {
                  acceptEmail = value ?? false;
                });
              },
              title: const Text('I accept email notifications'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    ];
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    againPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Stepper(
        currentStep: currentStep,
        steps: stepperSteps,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(
                    currentStep == stepperSteps.length - 1
                        ? 'Register'
                        : 'Continue',
                  ),
                ),
                if (currentStep > 0) ...[
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
