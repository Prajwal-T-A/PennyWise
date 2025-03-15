// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pennywise/homepage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //background Colour
        backgroundColor: const Color.fromARGB(255, 34, 32, 32),
        body: Center(
            child: Column(
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: Image.asset(
                'lib/images/applogo.png',
                height: 350,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            //title
            Text(
              'PENNYWISE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //subtitles
            const Text(
              'AI-Driven Personalized Financial Structuring System',
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 70,
            ),

            //start now
            GestureDetector(
              onTap: () => Navigator.push(
                context,  
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: const Text(
                      'Begin Planning',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )),
            )
          ],
        )));
  }
}
