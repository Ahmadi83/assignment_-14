
import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';



class Report_page extends StatefulWidget {
  const Report_page({super.key});

  @override
  State<Report_page> createState() => _Report_pageState();
}

class _Report_pageState extends State<Report_page> {


  String? selectedOption;

  String _timeString ='';
  String _DateString ='';
  String _week_day = "";



var radis =5.0;

 ChartData (title,coloor,radius,amount){
  return PieChartSectionData(
    value: amount,
     title: title,
     color: coloor,
     radius: radius,
    borderSide: BorderSide(color: Colors.red,strokeAlign: 2,width: 2),
   );
 }


  @override
  void initState() {
    super.initState();
    _UpdateTime();
    Timer.periodic(Duration(seconds: 1),(Timer t ) =>_UpdateTime() );

  }

  void _UpdateTime(){
    final DateTime now = DateTime.now();
    final String FormattedTime = DateFormat('hh:mm a').format(now);
    final String FormattedDate = DateFormat('dd / MM / yyyy').format(now);
    final String FormattedDay = DateFormat('EEEE').format(now);

    setState(() {
      _timeString = FormattedTime;
      _DateString = FormattedDate;
      _week_day   = FormattedDay;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],

        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.green,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text('$_DateString',style: TextStyle(fontSize: 16,color: Colors.white,),),
            )
          ],
          leading:Padding(
            padding: const EdgeInsets.only(top: 15),

            child: Text(_week_day,style: TextStyle(fontSize: 18,color: Colors.white),),
          ),

          title: Text(
            'Reports',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leadingWidth: 100,
        ),


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
            SizedBox(height: 35,),

            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 50),
              child: CircleAvatar(radius: 150,backgroundColor: Colors.white,
                child: PieChart(
                  PieChartData(
                      sectionsSpace: 2,
                    startDegreeOffset: 30.0,
                    titleSunbeamLayout: false,
                    centerSpaceColor:  Colors.white,
                    centerSpaceRadius: 60,
                   sections: [
                    ChartData('Petrol', Colors.orangeAccent, 80.0,radis),
                    ChartData('Diesel', Colors.blue, 80.0,50.0),
                    ChartData('A1_Petrol', Colors.green, 80.0,30.1),


                   ]
                  )
                ),
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(width: 200,height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.orangeAccent,
                        offset: Offset(4, 4,),
                        blurRadius: 15,
                        spreadRadius: 4
                      ),
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(-2, -2,),
                          blurRadius: 15,
                          spreadRadius: 4
                      ),

                    ]
                  ),
                   child: Center(child: Text('Total : 12500  ',
                     style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(left: 10,right: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                container(Colors.green, 1500,'A1_Petrol'),
                SizedBox(width: 7,),
                container(Colors.orange, 7500,"Petrol"),
                  SizedBox(width: 7,),
                  container(Colors.blue,3500,"Diesel "),
                ],
              ),
            )
          ],
        ));

  }
}



 container(color,amount,name){
  return Padding(
    padding: const EdgeInsets.only(top: 30,),
    child: Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(4, 4,),
                blurRadius: 15,
                spreadRadius: 4),
            BoxShadow(
                color: Colors.black54,
                offset: Offset(-2, -2,),
                blurRadius: 15,
                spreadRadius: 4),
          ]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$name',
            style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color),
          ),
          Text('$amount AF',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  );
 }
