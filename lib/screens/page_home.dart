import 'package:flutter/material.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1A589),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff60873a),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffc5bfbc),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text("Sign In"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfffb4909),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/register'); // ← redirection vers Register
                        },
                        child: const Text("Register"),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(
                          text: "Take ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        TextSpan(
                          text: "control",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 18),
                        ),
                        TextSpan(
                          text: " of your budget!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: "Outils rapides",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _iconBox(Icons.account_balance_wallet, "Portefeuille"),
                  _iconBox(Icons.savings, "Épargne"),
                  _iconBox(Icons.show_chart, "Analyse"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: "Statistiques rapides",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statCard("Dépenses", "450€"),
                  _statCard("Économies", "220€"),
                  _statCard("Objectif", "800€"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: "Aperçu visuel",
              child: _fakeBarChart(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ===== Widgets =====

  Widget _headerBtn(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff79a94a),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.blue[50]!.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 40, color: Colors.orange),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _fakeBarChart() {
    final colors = [Colors.orange, Colors.green, Colors.blue, Colors.purple];
    final heights = [60.0, 100.0, 80.0, 40.0];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        heights.length,
        (i) => Container(
          width: 20,
          height: heights[i],
          decoration: BoxDecoration(
            color: colors[i],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
