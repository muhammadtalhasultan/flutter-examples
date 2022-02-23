import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/screens/screens.dart';
import 'package:tiktok_clone/services/auth_service.dart';
import 'package:tiktok_clone/utils.dart';
import 'package:tiktok_clone/widgets/avatar.dart';
import 'package:tiktok_clone/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    File? _image;
    bool _isLoading = false;

    void selectImage() {
      File im = pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
    }

    AuthServices auth = AuthServices();
    doRegister() {
      setState(() {
        _isLoading = true;
      });
      auth.registerUser(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          image: profilePhoto);
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignIn(),
        ),
      );
    }

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
              InkWell(
                onTap: () => {selectImage()},
                child: _image == null
                    ? const Avatar(imageSrc: 'assets/images/profile.png')
                    : CircleAvatar(
                        backgroundImage: FileImage(_image!),
                        radius: 30,
                      ),
              ),
              const SizedBox(height: 15),
              TextInput(
                controller: _usernameController,
                labelText: 'Username',
                prefixIcon: const Icon(Icons.person_outlined),
              ),
              const SizedBox(height: 10),
              TextInput(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 10),
              TextInput(
                controller: _passwordController,
                labelText: 'Password',
                isObscure: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => {doRegister()},
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const SubmitButton(text: 'Sign Up'),
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
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    child: const Text('Sign in'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
