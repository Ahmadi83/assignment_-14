import 'package:assignment_14/Add_Sales.dart';
import 'package:assignment_14/Change_amount.dart';
import 'package:assignment_14/List_Page.dart';
import 'package:assignment_14/Reports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigat_page extends StatefulWidget {
  const BottomNavigat_page({super.key});

  @override
  State<BottomNavigat_page> createState() => _BottomNavigat_pageState();
}

class _BottomNavigat_pageState extends State<BottomNavigat_page> {

  PageController _pageController = PageController();

  int _selectedindex = 0;

  List<Widget> screens =[
    ListPage(),
    Add_Sales(),
    Report_page(),

  ];

  void _onchanged (int index){
    setState(() {
      _selectedindex =index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5,top: 3),
        child: CustomNavigationBar(
          backgroundColor: Colors.green,
          isFloating: true,
          elevation: 2,
          iconSize: 35,
          borderRadius: Radius.circular(15),
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          strokeColor: Colors.green,
          items: [
            CustomNavigationBarItem(icon: _selectedindex == 0 ? Icon(Icons.home): Icon(Icons.home_outlined) ,),
            CustomNavigationBarItem(icon: _selectedindex == 1 ? Icon(Icons.note_add): Icon(Icons.note_add_outlined) ,),
            CustomNavigationBarItem(icon: _selectedindex == 2 ? Icon(Icons.pie_chart): Icon(Icons.pie_chart_outline) ,),
          ],
          onTap: (int i) {
          _pageController.jumpToPage(i);
          } ,
          currentIndex: _selectedindex,
        ),
      ),

      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: _onchanged,

      ),
    );
  }
}
