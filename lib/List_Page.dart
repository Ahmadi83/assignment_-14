import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _MyAppState();
}

class _MyAppState extends State<ListPage> {
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
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            print('Floating Action Pressed');
          },
          shape:  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.save_as_outlined,color: Colors.black87,)
      ),

        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
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
