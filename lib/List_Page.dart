import 'dart:io';
import 'package:assignment_14/About.dart';
import 'package:assignment_14/Change_amount.dart';
import 'package:assignment_14/Database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:assignment_14/Add_Sales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';


class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _MyAppState();
}

class _MyAppState extends State<ListPage> {

  List<Sales> _sales=[];
   List<Sales> _filterSales =[];


   String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage()async{
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


 var _size_Icon = 30.0;

  list_tile(icon,name,press){
   return
   Padding(
     padding: const EdgeInsets.all(8.0),
     child: ListTile(
       splashColor: Colors.white70,
       leading: icon,
       title: Text('$name'),
       onTap: press,
     ),
   );

  }



  String? selectedFilter = 'All Sales' ;

  List<String> filterOptions = [
    'All Sales',
    'Petrol Sales',
    'Diesel Sales',
    'A_1 Petrol'
  ];

  bool IconTheme_State = false;


  Future<void> _fetchSales () async{
    List<Sales>? sales = await DatabaseHelper.getAll_Sales();
    setState(() {
      _sales =sales!;
      _filterSales = _sales.where((sale)=> sale.date == todayDate).toList();
    });
  }


  void _FilterSales(String? filter){
    setState(() {
      selectedFilter = filter;
      if(filter == 'All Sales'){
        _filterSales = _sales.where((sale)=> sale.date == todayDate).toList();
      }else if(filter == 'Petrol Sales'){
        _filterSales = _sales.where((sale)=> sale.comodity == 'petrol' && sale.date == todayDate ).toList();
      }else if(filter == 'Diesel Sales'){
        _filterSales = _sales.where((sale)=> sale.comodity == 'diesel' && sale.date == todayDate).toList();
      }else if(filter == 'A_1 Petrol'){
        _filterSales = _sales.where((sale)=> sale.comodity == 'A1_PETROL' && sale.date == todayDate).toList();
      }

    });
  }




@override
  void initState() {
    super.initState();
    // selectedFilter = 'Petrol Sales';
    _fetchSales();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.orange[100],
        drawer: Drawer(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Padding(
               padding: const EdgeInsets.only(left: 20,top: 50),
               child: Row(
                 children: [
                   CircleAvatar(radius: 60,backgroundImage: _image != null ? FileImage(_image!): null,),
                   SizedBox(width: 110,),

                   Padding(
                     padding: const EdgeInsets.only(bottom: 80),
                     child: IconButton(
                         iconSize: 25,
                         onPressed: (){
                           _pickImage();
                         },
                         icon: Icon(Icons.file_download_outlined)),
                   ),
               ],),
             ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(right: 180),
                child: Text('Name',style: TextStyle(fontSize: 25),),
              ),

              Divider(indent: 10,endIndent: 10,),



              list_tile(Icon(Icons.currency_exchange_sharp,size:_size_Icon ),'Change', (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Change_file(),));
                print('Changes Clicked');
              }),

              list_tile(Icon(Icons.settings,size:_size_Icon ,),'Settings', (){
              }),

              list_tile(Icon(Icons.share,size:_size_Icon ,),'Share', (){
                print('Share Clicked');
              }),

              list_tile(Icon(Icons.account_box_outlined,size:_size_Icon ), "About", (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => About(),));
                print('About');
              }),

              list_tile(Icon(Icons.exit_to_app,size:_size_Icon ), 'Exit' , (){
                print('Exit');
              })


            ],
          ),
        ),



        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('SALES',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: [Padding(
            padding: const EdgeInsets.only(right: 15,bottom: 20),
            child: IconButton(
              icon: IconTheme_State ==false? Icon(Icons.sunny): Icon(Icons.shield_moon_outlined),
              onPressed: (){
                setState(() {
                  IconTheme_State = !IconTheme_State;
                });
                print("Theme Selected");
              },
              iconSize: 27,
            ),
          )],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange[200],
                      radius: 25,
                      child: Text('${_filterSales.length}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    ),
                  ),

                  DropdownButton<String>(
                      icon: Icon(Icons.filter_alt),
                      iconEnabledColor: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                      elevation: 20,
                      underline: Divider(
                        color: Colors.red,),

                      value: selectedFilter,
                      hint: Text('All Sales'),
                      itemHeight: 60,
                      items: filterOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          child: Text(option),
                          value: option,
                        );
                      }).toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          selectedFilter = newvalue;
                          _FilterSales(newvalue);
                        });

                      })
                ],
              ),
              Divider(
                color: Colors.black87,
                indent: 12,
                endIndent: 12,
              ),
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var sale = _filterSales[index];
                   return SizedBox(
                     height: 110,
                     child: Card(
                       color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                              splashColor: Colors.orange,
                              title: Text('${sale.date}'),
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("${sale.price} AF ", style: TextStyle(fontSize: 18,color: Colors.black),),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${sale.amount} ', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                                        Text(' Liters', style: TextStyle(fontSize: 18,)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Text('${sale.comodity?.toUpperCase()}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                              onLongPress: ()  async{
                              await showDialog(context: context, builder: (context) =>  AlertDialog(
                                 title: Text('Do you Want to delete'),
                                actions: [
                                  MaterialButton(onPressed: () async{
                                    await DatabaseHelper().Delete_Sale(sale.id!);
                                    Navigator.pop(context);
                                    _fetchSales();
                                   },child: Text('Yes'),
                                  color: Colors.green,),


                                  Padding(
                                    padding: const EdgeInsets.only(left:12,right: 12),
                                    child: MaterialButton(onPressed: (){
                                      Navigator.pop(context);
                                     },child:  Text('No'),color: Colors.red,),
                                  ),
                                ],));

                              },
                            ),
                          )
                      ));


                },

                itemCount:   _filterSales.length
              ))
            ],
          ),
        ));
  }
}





//
