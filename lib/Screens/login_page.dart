import 'package:flutter/material.dart';
import '../utils/styles.dart';

class PageLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Texte d'accueil
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Login here", style: AppTextStyles.loginTitle),
                    SizedBox(height: 10),
                    Text("Welcome back! You’ve been missed!",
                        style: AppTextStyles.loginSubtitle),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Bloc du formulaire
              Container(
                width: 300,
                padding: EdgeInsets.all(15),
                decoration: AppBoxStyles.formContainer,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(decoration: AppInputStyles.emailField),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: AppInputStyles.passwordField,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: AppButtonStyles.primaryButton,
                onPressed: () {},
                child: Text("Se connecter", style: AppTextStyles.buttonText),
              ),

              SizedBox(height: 10), // petit espace entre les boutons

              ElevatedButton(
                style: AppButtonStyles.secondaryButton,
                onPressed: () {},
                child: Text("Créer un compte", style: AppTextStyles.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
