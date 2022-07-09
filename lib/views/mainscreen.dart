
import 'package:flutter/material.dart';


import 'package:my_tutor1/model/user.dart';
import 'package:my_tutor1/views/subjects.dart';

import 'package:my_tutor1/views/tutors.dart';


class MainScreen extends StatefulWidget {
    final User user; //from login and user dart  save data

  const MainScreen({Key? key, required this.user ,}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int _selectedIndex = 0;
  String maintitle = "Subjects";
  late double screenHeight, screenWidth, resWidth;

    


  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _pages = <Widget>[
     Subjects(user:widget.user),
     Tutors(),
     Icon(Icons.subscript, size: 150,),
  Icon(Icons.favorite,size: 150,),
  Icon(Icons.person,size: 150,),
    ];
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      
     
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        fixedColor: Colors.amber,
      
        unselectedItemColor:Colors.black,
        items: const[

          BottomNavigationBarItem(icon: Icon( Icons.subject),label: "Subjects"),

          BottomNavigationBarItem(icon: Icon(Icons.school),label: "Tutors"),

          BottomNavigationBarItem(icon: Icon(Icons.subscript), label: "Subscribe"),

          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
         onTap: onTabTapped,
        currentIndex: _selectedIndex,
      ),
      body: Center(
    child: _pages.elementAt(_selectedIndex), //New
  ),
    );
    
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    
    });
  }
}