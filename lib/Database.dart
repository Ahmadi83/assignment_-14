
import 'dart:async';

import 'package:assignment_14/Database.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseHelper{

  static const  int _version = 1;
  static const  String _name = 'Fuel.db';

  static Future<Database> _getdb() async{

    return openDatabase( join( await getDatabasesPath(),_name),
        version: _version,

        onCreate: (db, version) async{
          await db.execute('CREATE TABLE sales (id INTEGER PRIMARY KEY AUTOINCREMENT , comodity TEXT , amount INTEGER , price INTEGER ,date TEXT )');
          await db.execute('CREATE TABLE changes( id INTEGER PRIMARY KEY AUTOINCREMENT , petrol_price INTEGER , diesel_price INTEGER, a1_price INTEGER)');

        },
    );}


  // Future<int> getAllSalesId (int id)async {
  //   final db = await _getdb();
  //   return await db.delete('sales', where: 'id = ?', whereArgs: [id],);
  // }


  Future<int> addChange (Changes changes)async{
    final db = await _getdb();
    return await db.insert("changes",changes.tojson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> Delete_Change ()async{
    final db = await _getdb();
    return await db.delete('changes');
  }



  Future<int> addSale (Sales sales)async{
   final db = await _getdb();
   return await db.insert("sales",sales.tojson(),
   conflictAlgorithm: ConflictAlgorithm.replace);
  }

   Future<int?> Delete_Sale (int id )async{
    final db = await _getdb();
     await db.delete('sales',where: 'id = ?',whereArgs: [id]);
    await db.rawDelete('DELETE FROM sqlite_sequence WHERE name = ?', ['sales']);
  }

  static Future<List<Sales>?> getAll_Sales()async{
    final db= await _getdb();
    final List<Map<String,dynamic>> maps = await db.query('sales');
    return List.generate(maps.length, (index)=> Sales.fromjson(maps[index]),
    );
  }


  static Future<List<Changes>?> getAll_Changes()async{
    final db= await _getdb();
    final List<Map<String,dynamic>> maps = await db.query('changes');
    return List.generate(maps.length, (index)=> Changes .fromjson(maps[index]),);
  }


  Future<int> getNextId()async {
    final db = await _getdb();
    final result = await db.rawQuery('SELECT MAX(id) + 1 as next_id FROM sales');
    int? nextid = result.first['next_id'] as int? ?? 1;
    return nextid;
  }


  static Future<DateTime?> getEarliestDate()async{
    final db = await _getdb();
    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT MIN(date) as min_date FROM sales');
    if(result.isNotEmpty && result.first['min_date'] != null){
      return DateTime.parse(result.first['min_date']);
    }else{
      return null;
    }
  }

}




class Sales {
  final int? id;
  final String? comodity;
  final int? amount;
  final int? price ;
  final String? date;

  const Sales({this.id, required this.comodity, required this.amount, required this.price, required this.date});

  factory Sales.fromjson(Map<String,dynamic> json) => Sales(
    id: json['id'],
    comodity: json['comodity'],
    amount: json['amount'],
    price: json['price'],
    date: json['date']
  );

  DateTime getDataAsDateTime(){
    return DateTime.parse(date!);
  }

  Map<String,dynamic> tojson()=>{
    'id':id,
    'comodity': comodity,
    'amount': amount,
    'price': price,
    'date': date
  };




}


class Changes{


   int? petrol;
   int? diesel;
   int? a1_price;

   Changes({required this.petrol,required this.diesel,required this.a1_price});

  factory Changes.fromjson(Map<String,dynamic> json) => Changes(

      petrol: json['petrol_price'],
      diesel: json['diesel_price'],
      a1_price: json['a1_price']
  );



   Map<String,dynamic> tojson()=>{
     'petrol_price': petrol,
     'diesel_price': diesel,
     'a1_price': a1_price,

   };



}


