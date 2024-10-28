import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';



class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,title: Text('About me'),),
      body:
        Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 80,

                backgroundImage: AssetImage('images/me.jpg')),

            SizedBox(height: 20,),

            AnimatedTextKit(animatedTexts:
            [WavyAnimatedText("Abdul Razeq",textStyle: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
              speed: Duration(milliseconds: 200),),

              TyperAnimatedText('AHMADI',textStyle: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.green),
                speed: Duration(milliseconds: 350),),


            FadeAnimatedText('Mobile Developer',textStyle: TextStyle(fontSize:30,fontWeight: FontWeight.bold ,color: Colors.pinkAccent),
                duration: Duration(seconds: 2)),

            ],
            isRepeatingAnimation: true,),


            Padding(
              padding: const EdgeInsets.only(right: 40,left: 20,top: 50,bottom: 20),
              child: Container(
                height: 1,width: 280,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 15,bottom: 10),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.green,),
                  child: ListTile(title: Text("abdulrazeqahmadii@gmail.com",style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.email,color: Colors.white,),)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 5),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Colors.green,),
                child: ListTile(title: Text("+93 - 791336750",style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.call,color: Colors.white,),),
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(onTap: () async{
                  final nlink="https://t.me/ABDULRAZEQAHMADII";
                  final link =Uri.parse(nlink);
                  await launchUrl(link);
                },
                  child: CircleAvatar(radius: 30,
                    backgroundImage: AssetImage('images/telegram.jpg'),),
                ),

                SizedBox(width: 15,),

                GestureDetector(onTap: ()async{
                  final link ='https://www.linkedin.com/in/abdul-razeq-ahmadi-563110308';
                  final openlink =Uri.parse(link);
                  await launchUrl(openlink);
                },
                 child:  CircleAvatar(radius: 25,
                 backgroundImage: AssetImage('images/linkdin.jpg'),),),

                SizedBox(width: 15,),


                GestureDetector(onTap: ()async{
                  final link ='https://github.com/Ahmadi83';
                  final openlink =Uri.parse(link);
                  await launchUrl(openlink);
                },
                  child:  CircleAvatar(radius: 25,
                 backgroundImage: AssetImage('images/gitgub.jpg'))),
               ],
            ),


          ],



        )
    );
  }
}