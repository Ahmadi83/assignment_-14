import 'dart:async';
import 'package:assignment_14/Database.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Add_Sales extends StatefulWidget {


  final Sales? sales;
   Add_Sales({super.key,this.sales,});

  @override
  State<Add_Sales> createState() => _MyAppState();
}

class _MyAppState extends State<Add_Sales> {
  
  List<Sales>? _sales=[];

  String? selectedOption;


  String _timeString ='';
  String _DateString ='';
  String _week_day = "";



  List<Changes> _changes_list=[];

  Future<void> _fetch_changes () async{
    List<Changes>? changes = await DatabaseHelper.getAll_Changes();
    setState(() {
      _changes_list =changes!;
    });
  }


  int? next_id;
  void _loadNext_id () async{
    int? id = await DatabaseHelper().getNextId();
    setState(() {
       next_id =id;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetch_changes();
    _UpdateTime();
    Timer.periodic(Duration(seconds: 1),(Timer t ) =>_UpdateTime() );
    _loadNext_id();
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


  // Future<void> _fetchSales () async{
  //   List<Sales>? sales = await DatabaseHelper.getAll_Sales();
  //   setState(() {
  //     _sales =sales!;
  //   });
  // }

 TextEditingController id_control = TextEditingController();
 TextEditingController comodity_control = TextEditingController();
 TextEditingController amount_control = TextEditingController();
 TextEditingController Discount_control = TextEditingController();






  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.orange[150],
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
              Text(_week_day,style: TextStyle(fontSize: 16,color: Colors.white),),
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
          
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
             child: Row(children: [
               CircleAvatar(child:  Text('1',style: TextStyle(fontSize: 30),),
                 radius: 28,
                 backgroundColor: Colors.green,
               ),
               SizedBox(width: 5,),

               Container(
                 width: 300,height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(10),color: Colors.white,),
                 child: Padding(
                   padding: const EdgeInsets.only(top: 15,left: 10),
                   child: Text('ID  : ${next_id}',style: TextStyle(fontSize: 18),),
                 ),
               )
             ],),
           ),

          Padding(
            padding:  EdgeInsets.only(left: 15,right: 15),
            child: Row(
              children: [
                CircleAvatar(child:  Text('2',style: TextStyle(fontSize: 30),),
                  radius: 28,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 5,),


                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),

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
                        DropdownMenuItem(value: 'petrol', child: Text('Petrol')),
                        DropdownMenuItem(value: 'diesel', child: Text('Diesel')),
                        DropdownMenuItem(value: 'A1_PETROL', child: Text('A1_Petrol')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),


          SizedBox(height: 15,),

          Textfiled('3', 'Liters',amount_control,TextInputType.numberWithOptions()),
          Textfiled('4', 'Discount %',Discount_control,TextInputType.numberWithOptions()),

          Padding(
            padding: const EdgeInsets.only(left: 130,top: 40),
            child:MaterialButton(
              splashColor: Colors.orangeAccent,
              shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),

              onPressed: ()async{
                final comodity  = selectedOption;
                final amount = int.parse(amount_control.value.text);
                final price =  comodity == 'petrol'?
                    _changes_list[0].petrol! * amount :
                    comodity == 'diesel'?
                    _changes_list[0].diesel! * amount :
                    comodity == 'A1_PETROL' ?
                    _changes_list[0].a1_price! * amount:
                        null;
                final Discount = int.parse(Discount_control.value.text );


                final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

                if(selectedOption == null ){
                  return ;
                }

                 final Sales model = Sales( comodity: comodity, amount: amount, price:price,date: date);

                await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved!')));
                 await DatabaseHelper().addSale(model);

               setState(() {
                 _loadNext_id();
                 id_control.clear();
                 comodity_control.clear();
                 amount_control.clear();
                 Discount_control.clear();
               });
              },

              color: Colors.green,
              height: 50,
              minWidth: 150,
              child: Text('Save',),
            )
          )
        ],
      ));

  }
}



// This is an Widget for Easy Work That I make it-----------

 Textfiled(String txt, String texthint,controll,keyboardtype){
  return Padding(
    padding: const EdgeInsets.only(right: 15,left: 15,bottom: 15),
    child: Row(
      children: [
        CircleAvatar(child:  Text('$txt',style: TextStyle(fontSize: 30),),
          radius: 28,
          backgroundColor: Colors.green,
        ),
        SizedBox(width: 5,),
        Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
              // color: Colors.white,
              child: TextField(
                keyboardType: keyboardtype,
                controller: controll,
                decoration: InputDecoration(
                  hintText: '$texthint',
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)), ),
              ),
            ))
      ],
    ),
  );
}

