import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/screens.dart';
import 'package:tiktok_clone/services/auth_service.dart';
import 'package:tiktok_clone/utils.dart';
import 'package:tiktok_clone/widgets/widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TikTok',
                style: TextStyle(
                    color: buttonColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              TextInput(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextInput(
                controller: _passwordController,
                labelText: 'Password',
                isObscure: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => {
                  AuthServices().loginUser(
                      _emailController.text, _passwordController.text, context),
                },
                child: const SubmitButton(text: 'Sign In'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
