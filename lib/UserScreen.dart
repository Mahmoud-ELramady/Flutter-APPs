import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserModel{
  final int id;
  final String name;
  final String phone;

  UserModel({
    @required this.id,
   @required this.name,
   @required this.phone,
});
}


class UserScreen extends StatelessWidget {

  List<UserModel> users=[
    UserModel(id: 1, name: "Mahmoud ELramady", phone: "+201024162100"),
    UserModel(id: 2, name: "ALi Amr", phone: "+20103842150"),
    UserModel(id: 3, name: "Khaled Waleed", phone: "+20123571131"),
    UserModel(id: 1, name: "Mahmoud ELramady", phone: "+201024162100"),
    UserModel(id: 2, name: "ALi Amr", phone: "+20103842150"),
    UserModel(id: 3, name: "Khaled Waleed", phone: "+20123571131"),
    UserModel(id: 1, name: "Mahmoud ELramady", phone: "+201024162100"),
    UserModel(id: 2, name: "ALi Amr", phone: "+20103842150"),
    UserModel(id: 3, name: "Khaled Waleed", phone: "+20123571131"),
    UserModel(id: 1, name: "Mahmoud ELramady", phone: "+201024162100"),
    UserModel(id: 2, name: "ALi Amr", phone: "+20103842150"),
    UserModel(id: 3, name: "Khaled Waleed", phone: "+20123571131"),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body:ListView.separated(
          itemBuilder: (context,index)=>buildUserItem(users[index]),
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length
      ) ,
    );
  }


  Widget buildUserItem(UserModel users)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          child: Text("${users.id}",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${users.name}",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text("${users.phone}")

          ],
        ),
      ],
    ),
  );
}
