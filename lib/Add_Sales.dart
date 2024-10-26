import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Add_Sales extends StatefulWidget {
  const Add_Sales({super.key});

  @override
  State<Add_Sales> createState() => _MyAppState();
}

class _MyAppState extends State<Add_Sales> {

  String? selectedOption;

  String _timeString ='';
  String _DateString ='';
  String _week_day = "";


  @override
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

 TextEditingController con1 = TextEditingController();
 TextEditingController con2 = TextEditingController();
 TextEditingController con3 = TextEditingController();
 TextEditingController con4 = TextEditingController();

  Textfiled(String txt, String texthint,controll){
  return Padding(
     padding: const EdgeInsets.only(right: 15,left: 15,bottom: 15),
     child: Row(
       children: [
         CircleAvatar(child:  Text('$txt',style: TextStyle(fontSize: 30),),radius: 28,),
         SizedBox(width: 5,),
         Expanded(
             child: TextField(
               controller: controll,
               decoration: InputDecoration(
                   hintText: '$texthint',
                   border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
             ))
       ],
     ),
   );
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text('$_timeString',style: TextStyle(fontSize: 18,color: Colors.white,),),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 15,top: 6),
          child: Column(
            children: [
              Text(_week_day,style: TextStyle(fontSize: 18,color: Colors.white),),
              SizedBox(height: 5,),
              Text(_DateString,style: TextStyle(fontSize: 12,color: Colors.white),),
            ],
          ),
        ),

        leadingWidth: 100,
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        title: Text('ADD SALES',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Textfiled('1', 'ID',con1,),


          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Row(
              children: [
                CircleAvatar(child:  Text('2',style: TextStyle(fontSize: 30),),radius: 28,),
                SizedBox(width: 5,),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    icon: Icon(Icons.playlist_add_check_outlined),
                    decoration: InputDecoration(
                      hintText: 'Comodity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    value: selectedOption,
                    items: [
                      DropdownMenuItem(value: 'گزینه اول', child: Text('Petrol')),
                      DropdownMenuItem(value: 'گزینه دوم', child: Text('Diesel')),
                      DropdownMenuItem(value: 'گزینه سوم', child: Text('A1_Petrol')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),

          Textfiled('3', 'Amount',con3),
          Textfiled('4', 'Price',con3),

          Padding(
            padding: const EdgeInsets.only(left: 130,top: 40),
            child:MaterialButton(
              onPressed: (){
                print('Save Button Clicked');
              },
              color: Colors.orangeAccent,
              height: 50,
              minWidth: 150,
              child: Text('Save'),
            )
          )
        ],
      ));

  }
}
