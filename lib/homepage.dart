import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pennywise/appinfo.dart';
import 'package:pennywise/epf.dart';
import 'package:pennywise/retirement.dart';
import 'package:pennywise/settings.dart';
import 'package:pennywise/terms.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 32, 32),
      appBar: AppBar(
        title: const Text("Finance Structuring"),
        backgroundColor: Colors.blue,
        elevation: 0,
        //leading: const Icon(Icons.menu),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      // ignore: prefer_const_constructors
      drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 122, 124, 122),
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'lib/images/applogo.png', // Path to your logo
                  fit: BoxFit.contain, // Ensures the image scales appropriately
                  height: 48, // Adjust height if needed
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("H O M E"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Terms()));
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("A B O U T"),
              ),
            ],
          )),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //Row 1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EPF(),
                    ),
                  );
                },

                //First Feature
                child: Container(
                    height: 140,
                    width: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 38, 70, 83),
                      //curve the corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 88, vertical: 55),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Finance Tracking",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),

        //Row 2
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Retirement(),
                    ),
                  );
                },

                //First Feature
                child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 85, 158, 187),
                      //curve the corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 55),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Retirement Planning",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),

        //Row 3
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Third Feature
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  );
                },
                child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 98, 69, 132),
                      //curve the corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 75, vertical: 55),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Settings and Profile",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),

        //Fourth Row :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Appinfo(),
                    ),
                  );
                },
                //Fourth Feature
                child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 97, 84, 156),
                      //curve the corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 82, vertical: 55),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "General information",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),
      ]),
    );
  }
}
