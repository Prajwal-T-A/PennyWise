// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Appinfo extends StatelessWidget {
  const Appinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("General Finance Information"),
          backgroundColor: const Color.fromARGB(255, 97, 84, 156),
        ),
        backgroundColor: Colors.black,
        // ignore: prefer_const_constructors
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "EPF (Employees' Provident Fund) : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "What it is: A retirement savings scheme for salaried employees.\n\n"
                    "How it works: Contributions are made by both the employer and employee.\n\n"
                    "Key features:\n"
                    "  * Mandatory for most salaried employees.\n"
                    "  * Tax benefits on contributions and withdrawals.\n"
                    "  * Managed by the Employees' Provident Fund Organization (EPFO).\n\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: "PPF (Public Provident Fund) : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "What it is: A government-backed savings scheme available to all Indian residents.\n\n"
                    "Key features:\n"
                    "* Tax benefits on contributions and returns\n"
                    "* Longer lock-in period (15 years)\n"
                    "* Lower interest rate than EPF\n"
                    "* Higher liquidity than EPF after 5 years\n"
                    "* Can be opened by anyone, including self-employed individuals\n\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: "Mutual Funds : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "What it is: A concept where a fund manager invests in various portfolios\n\n"
                    "Key features:\n"
                    "* Equity - Stocks, High risk, high reward \n"
                    "* Debt - Bonds, Low risk, low reward\n"
                    "* Hybrid - Combinations of both Equity and Debt\n\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: "SIPs (Systematic Investment Plans) : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "What it is: Investing fixed amounts in mutual funds at regular intervals (usually monthly).\n\n"
                    "Key features:\n"
                    "* Discipline: Encourages consistent saving.\n"
                    "* Affordability: Start small, gradually increase.\n"
                    "* Rupee Cost Averaging: Reduces market impact.\n"
                    "* Compounding: Builds wealth over time.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ]),
          ),
        )));
  }
}
