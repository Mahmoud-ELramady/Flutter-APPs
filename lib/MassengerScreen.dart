
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MassengerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/47406119?s=400&u=c3092f4b0f5f79710767ed50279b9ed2474e0fa4&v=4"),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
                "Chats",
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.blue,
          child: Icon(
          Icons.camera_alt,
          size: 15,
          color: Colors.white,
          )
          ),
              onPressed: (){},

              ),
          IconButton(icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                size: 15,
                color: Colors.white,
              )
          ),
            onPressed: (){},

          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Search"),

                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=>buildStatusItem(),
                    separatorBuilder: (context,index)=>SizedBox(width: 20.0,),
                    itemCount: 10,
                    ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder:(context,index){
                    return buildChatItem();
                  },
                  separatorBuilder:(context,index)=> SizedBox(height: 20.0,),
                  itemCount: 15
              )
            ],
          ),
        ),
      ),

    );
  }


  Widget buildChatItem()=>Row(
    children: [
      Stack(
        alignment:  AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage("https://cdn.britannica.com/04/171104-050-AEFE3141/Steve-Jobs-iPhone-2010.jpg"),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 3.0,
                end: 3.0
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mahmoud ELramady",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Hello my name mahmoud Hello my name mahmoudHello my name mahmoudHello my name mahmoudHello my name mahmoudHello my name mahmoud",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                  child: Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,

                    ),
                  ),
                ),
                Text("2.00AM"),

              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildStatusItem()=>Container(
    width: 60.0,
    child: Column(
      children: [
        Stack(
          alignment:  AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage("https://cdn.britannica.com/04/171104-050-AEFE3141/Steve-Jobs-iPhone-2010.jpg"),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0
              ),
              child: CircleAvatar(
                radius: 7.0,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "Steve Jobs",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );


}
