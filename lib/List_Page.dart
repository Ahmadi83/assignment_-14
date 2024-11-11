import 'dart:collection';
import 'dart:io';
import 'package:assignment_14/Change_amount.dart';
import 'package:image_picker/image_picker.dart';
import 'package:assignment_14/Add_Sales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _MyAppState();
}

class _MyAppState extends State<ListPage> {

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



  String? selectedFilter;
  List<String> filterOptions = [
    'فروشات پطرول ۱',
    'فروشات دیزل ۲',
    'فروشات پطرول روسی ۳'
  ];

  bool IconTheme_State = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // floatingActionButton: FloatingActionButton(
      //   splashColor: Colors.green,
      //     onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Sales(),));
      //       print('Floating Action Pressed');
      //     },
      //     shape:  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      //         child: Icon(Icons.save_as_outlined,color: Colors.black87,)
      // ),

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Change_file(),));
                print('Changes Clicked');
              }),

              list_tile(Icon(Icons.share,size:_size_Icon ,),'Share', (){
                print('Share Clicked');
              }),

              list_tile(Icon(Icons.account_box_outlined,size:_size_Icon ), "About", (){
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
                  DropdownButton<String>(
                      icon: Icon(Icons.filter_alt),
                      iconEnabledColor: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                      elevation: 20,
                      underline: Divider(
                        color: Colors.red,
                      ),
                      value: selectedFilter,
                      hint: Text('Filter'),
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
                   return Card(
                     color: Colors.orangeAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Column(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('1403/8/3',style: TextStyle(fontSize: 18),),
                            Text('4 Liters',style: TextStyle(fontSize: 18)),
                          ],
                        ),



                        trailing: Text('Petrol',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red),),
                        onTap: (){},
                      ),
                    ),
                  );
                },
                itemCount: 20,
              ))
            ],
          ),
        ));
  }
}

