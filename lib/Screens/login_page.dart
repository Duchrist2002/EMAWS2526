import 'package:flutter/material.dart';
import '../widgets/password_field.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1A589),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: const [
                  Text(
                    "Login here",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5A7C38),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome back! You’ve been missed!",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: 300,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        filled: true,
                        fillColor: const Color(0xfffcfefd),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const PasswordField(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1f9829),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1f9829),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Create new account",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Go Back to Home_Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
