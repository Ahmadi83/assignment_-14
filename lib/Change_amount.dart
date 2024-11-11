
import 'package:flutter/material.dart';
import 'BottomNavigation.dart';
import 'Database.dart';



class Change_file extends StatefulWidget {
  const Change_file({super.key});

  @override
  State<Change_file> createState() => _MyAppState();
}

class _MyAppState extends State<Change_file> {

  List<Changes> change=[];


  TextEditingController petrol_con = TextEditingController();
  TextEditingController diesel_con = TextEditingController();
  TextEditingController a1_petrol_con = TextEditingController();




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
                  keyboardType: TextInputType.number,
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
        backgroundColor: Colors.orange[100],
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.green,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigat_page(),));
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
              Textfiled('Petrol Price : ',Icon(Icons.attach_money_outlined), 'Enter Your Amount',petrol_con),
              Textfiled('Diesel Price :',Icon(Icons.attach_money_outlined) ,'Enter Your Amount', diesel_con),
              Textfiled('A_1 Petrol Price :', Icon(Icons.attach_money_outlined), 'Enter Your Amount',a1_petrol_con),

              Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child:MaterialButton(
                    splashColor: Colors.orangeAccent,
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),

                    onPressed: () async{

                      int petrol = int.parse(petrol_con.value.text) ;
                      int diesel =  int.parse(diesel_con.value.text);
                      int a1_petrol = int.parse(a1_petrol_con.value.text);

                      final Changes changes_model = Changes(
                        petrol: petrol,
                        diesel: diesel,
                        a1_price: a1_petrol,
                         );

                     //await change[0].petrol! != null && change[0].diesel! != null && change[0].a1_price! != null ?
                       DatabaseHelper().addChange(changes_model);
                      // DatabaseHelper().Delete_Change();



                      setState(() {
                        petrol_con.clear();
                        diesel_con.clear();
                        a1_petrol_con.clear();

                      });

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
