import 'package:flutter/material.dart';
import '../utils/styles.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 320,
              padding: EdgeInsets.all(20),
              decoration: AppBoxStyles.headerContainer,
              child: Column(
                children: [
                  // Ligne 1 → image + 2 boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                style: AppButtonStyles.headerButton1,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text("Sign In")),
                            SizedBox(width: 10),
                            ElevatedButton(
                                style: AppButtonStyles.headerButton2,
                                onPressed: () {},
                                child: Text("Register")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Take ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: "control", // mot spécifique
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: " of your budget!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                style: AppButtonStyles.headerButton3,
                                onPressed: () {},
                                child: Text("Sign In")),
                            SizedBox(width: 10),
                            ElevatedButton(
                                style: AppButtonStyles.headerButton3,
                                onPressed: () {},
                                child: Text("Register")),
                            ElevatedButton(
                                style: AppButtonStyles.headerButton3,
                                onPressed: () {},
                                child: Text("Sign In")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[50],
              child: Text("Box1!"),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[50],
              child: Text("Box 2!"),
            ),
            Text(
              "Bienvenue sur la page d'accueil !",
              style: AppTextStyles.loginTitle,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
