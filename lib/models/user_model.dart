import 'package:flutter/cupertino.dart';

class UserModel{
  final String uid;
  final String email;

  //constructor
UserModel({required this.uid,required this.email});

//retrieving data from firebase(it a map) and converting it dart object
factory UserModel.fromfirebase(Map<String,dynamic> data){
  return UserModel(uid:data['uid'], email:data['uid']);

}

}