import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider (){
    _loadThemeFromPrefs();
  }

  void toggleTheme(){
    _isDarkTheme = !_isDarkTheme;
    _SavedThemeToPrefs();
    notifyListeners();
  }


  Future<void> _loadThemeFromPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }



  Future<void> _SavedThemeToPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkTheme", _isDarkTheme);
  }



}



// for Theme Colors -----------



class Apptheme {


  //Light Theeme ---

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.orange[100],
    appBarTheme: AppBarTheme(color: Colors.green,),

  );

  // تم تیره
  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Color.fromRGBO(31, 26, 26, 100),
    appBarTheme: AppBarTheme(color: Colors.blueGrey,iconTheme: IconThemeData(color: Colors.white)),
    textTheme: TextTheme(titleMedium: TextStyle(color: Colors.red)),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.blueGrey),
    brightness: Brightness.light,
    visualDensity: VisualDensity.standard,





    

  );
}


