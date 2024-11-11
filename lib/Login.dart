import 'package:assignment_14/BottomNavigation.dart';
import 'package:assignment_14/List_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';





class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController control_1 = TextEditingController();
  TextEditingController control_2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.blue));
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,),
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Stack(
          children: [
            // پس زمینه زرد (مناطق مثلثی شکل)
              CustomPaint(
               painter: BackgroundPainter(),
               child: Container(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            // فرم لاگین در مرکز صفحه
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Login Form',style: TextStyle(fontSize: 40),),
                  SizedBox(height: 40),
                Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child:  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: control_1 ,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Name',
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 20),

                  Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 1),
                    ),


                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: control_2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Password',

                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20),
                  MaterialButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigat_page(),));
                  },
                     hoverElevation: 50,
                      height: 40,
                      minWidth: 120,
                      splashColor: Colors.blue,
                      color: Colors.red,
                      child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[100]!
      ..style = PaintingStyle.fill;

    Path leftPath = Path();
    leftPath.moveTo(0, 0);
    leftPath.lineTo(size.width * 0.5, size.height * 0.5);
    leftPath.lineTo(size.width * 0.5, size.height * 0.5);
    leftPath.lineTo(0, size.height);
    leftPath.close();

    Path rightPath = Path();
    rightPath.moveTo(size.width, 0);
    rightPath.lineTo(size.width * 0.5, size.height * 0.5);
    rightPath.lineTo(size.width * 0.5, size.height * 0.5);
    rightPath.lineTo(size.width, size.height);
    rightPath.close();

    canvas.drawPath(leftPath, paint);
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
