import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key , required this.payLoad}) : super(key: key);
final String payLoad;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = "";
  @override
  void initState() {
     _payload = widget.payLoad;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Column(
              children: [
                Text("Hello, Mostafa ",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? Colors.white :darkGreyClr,
                  ),),
                const SizedBox(height: 10,),
                Text("You have a new reminder",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode ? Colors.grey[100] :darkGreyClr,
                  ),),
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.text_format,
                          color: Colors.white,
                          size: 30,),
                          SizedBox(width: 10,),
                          Text("Title",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(_payload.toString().split("|")[0],
                        style:const   TextStyle(
                          color:  Colors.white ,
                          fontSize: 20,

                        ),),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Icon(Icons.description,
                            color: Colors.white,
                            size: 30,),
                          SizedBox(width: 10,),
                          Text("Description",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(_payload.toString().split("|")[1],
                        textAlign: TextAlign.justify,
                        style:const   TextStyle(
                          color:  Colors.white ,
                          fontSize: 20,

                        ),),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Icon(Icons.calendar_today,
                            color: Colors.white,
                            size: 30,),
                          SizedBox(width: 10,),
                          Text("Date",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(_payload.toString().split("|")[2],
                        style:const   TextStyle(
                          color:  Colors.white ,
                          fontSize: 20,

                        ),),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  AppBar appBar()
  {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: (){
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new,size: 24,color: primaryClr,),
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage("assets/images/person.jpeg"),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
