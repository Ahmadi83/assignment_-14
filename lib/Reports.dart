
import 'dart:async';
import 'dart:core';
import 'package:assignment_14/Database.dart';
import 'package:assignment_14/List_Page.dart';
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

  List<Sales> _sales=[];


  String? selectedOption;

  String _timeString ='';
  String _DateString ='';
  String _week_day = "";



var radis =65.0;

 ChartData (title,coloor,radius,amount){
  return PieChartSectionData(
    value: amount,
     title: title,
     color: coloor,
     radius: radius,
    borderSide: BorderSide(color: Colors.red,strokeAlign: 2,width: 2),
   );
 }

 

  Future<void> _fetchSales ([DateTime? date]) async{
    List<Sales>? allSales = await DatabaseHelper.getAll_Sales();
    setState(() {
      if(_selectedDate != null){
        _sales = allSales?.where((sale) => isSameDate(sale.getDataAsDateTime(), _selectedDate!)).toList() ?? [];
      }else {
        _sales = allSales ?? [];
      }
    });
  }


  bool isSameDate(DateTime date1,DateTime date2){
   return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }


  @override
  void initState() {
    super.initState();
    _fetchSales();
    _UpdateTime();
    _initialzeFirstDate();
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

  

  double _calculateTotalByFuelType(String fuelType) {
    return _sales.where((item) => item.comodity == fuelType)
        .fold(1.0, (sum, item) => sum + (item.price ?? 0));
  }


  double _calculateTotalByFuelType_Container(String fuelType) {
    return _sales.where((item) => item.comodity == fuelType)
        .fold(.0, (sum, item) => sum + (item.price ?? 0));
  }


  // This Part of Code is For Calendar (Data picker) and Intilized it -----

  DateTime? _selectedDate;
  DateTime? _firstDate;
  final _datacontroller = TextEditingController();

  Future<void> _initialzeFirstDate() async{
    DateTime? earliseDate = await DatabaseHelper.getEarliestDate();
    setState(() {
      _firstDate = earliseDate ?? DateTime(2000);
    });
  }


  Future<void> _selectDate (BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
     context: context,
      initialDate : _selectedDate ?? DateTime.now(),
      firstDate : _firstDate ?? DateTime(2000),
      lastDate : DateTime.now(),
    );
    if(pickedDate != null && pickedDate != _selectedDate){
      setState(() {
        _selectedDate = pickedDate;
        _datacontroller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      await _fetchSales(_selectedDate);
    }
  }

  // Calender Finished -----------



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
            padding: const EdgeInsets.only(top: 15,left: 10),

            child: Text(_week_day,style: TextStyle(fontSize: 17,color: Colors.white),),
          ),

          title: Text('Reports', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          centerTitle: true,
          leadingWidth: 100,
        ),


        body: ListView(
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 180,top: 20),
                child: Container(width: 150, height: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      color: Colors.white54,
                      border: Border.all(width: 0),
                    ),
                    child: TextField(
                       controller: _datacontroller,
                      readOnly: true,
                      onTap: ()=> _selectDate(context),
                      decoration: InputDecoration(
                        prefixIconColor: _selectedDate == null ? Colors.black : Colors.red,
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        border: InputBorder.none,
                        hintFadeDuration: Duration(milliseconds: 500),
                        hintText: ' Select Date',
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
                      ChartData('Petrol', Colors.green, 80.0,_calculateTotalByFuelType('petrol')?? 1),
                      ChartData('Diesel', Colors.blue, 80.0,_calculateTotalByFuelType('diesel')?? 0),
                      ChartData('A1_Petrol', Colors.orangeAccent, 80.0,_calculateTotalByFuelType('A1_PETROL')?? 0  ),


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
                     child: Center(child: Text('Total: ${_sales.fold(0.0, (sum, item) => sum + (item.price ?? 0))} AF',
                       style:   _sales.fold(0.0, (sum, item) => sum + (item.price ?? 0)) <=10000 ?
                       TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black):
                       TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),

    ))

                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 10,right: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    container(Colors.green,_calculateTotalByFuelType_Container('petrol') ,"Petrol"),
                    SizedBox(width: 7,),
                    container(Colors.blue,_calculateTotalByFuelType_Container('diesel'),"Diesel "),
                    SizedBox(width: 7,),
                    container(Colors.orange, _calculateTotalByFuelType_Container('A1_PETROL'),'A1_Petrol'),
                  ],
                ),
              )
            ],
          ),
       ]
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
          Text('${amount} AF',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  );
 }
