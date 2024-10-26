import 'package:assignment_14/List_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Change_file extends StatefulWidget {
  const Change_file({super.key});

  @override
  State<Change_file> createState() => _MyAppState();
}

class _MyAppState extends State<Change_file> {

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();

  Textfiled(String txt,icon, String texthint,controll){
    return Padding(
      padding: const EdgeInsets.only(right: 15,left: 15,bottom: 15),
      child: Row(
        children: [
          Text('$txt',style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.bold),),
          icon,

          SizedBox(width: 5,),
          Expanded(
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),

                child: TextField(
                  controller: controll,
                  decoration: InputDecoration(
                    hintText: texthint,
                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)), ),
                ),
              ))
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.green,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage(),));
            print('Home');
          },
          child:  Icon(Icons.home_outlined,
            size: 35,
            shadows: [Shadow(color: Colors.blue,offset: Offset(1,1.5))],

          ),
        ),

        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Change Amount',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
          centerTitle: true,
        ),



        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textfiled('Petrol Price : ',Icon(Icons.attach_money_outlined), 'Enter Your Amount',con1),
              Textfiled('Diesel Price :',Icon(Icons.attach_money_outlined) ,'Enter Your Amount', con2),
              Textfiled('A_1 Petrol Price :', Icon(Icons.attach_money_outlined), 'Enter Your Amount',con3),

              Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child:MaterialButton(
                    splashColor: Colors.orangeAccent,
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    onPressed: (){
                      print('Save Button Clicked');
                    },
                    color: Colors.green,
                    height: 50,
                    minWidth: 150,
                    child: Text('Change',),
                  )
              )
            ],
          ),
        )
    );
  }
}
