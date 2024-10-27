import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Report_page extends StatefulWidget {
  const Report_page({super.key});

  @override
  State<Report_page> createState() => _Report_pageState();
}

class _Report_pageState extends State<Report_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Reports',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,


        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40,top: 10),
              child: Container(width: 300, height: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all( width: 1),
                  ),
                  child: TextField(
                    // controller: control_2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'search',
                    ),
                  )),
            ),


          ],
        ));
  }
}
