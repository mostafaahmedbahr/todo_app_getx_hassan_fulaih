import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_getx_hassan_fulaih/controllers/task_controller.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/theme.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/widgets/button.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var taskCon = Get.put(TaskController());
  var titleCon = TextEditingController();
  var noteCon = TextEditingController();
  var selectDate = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = DateFormat("hh:mm a").format(
      DateTime.now().add(const Duration(minutes: 15)),
  ).toString();
  int selectRemind = 5;
  List<int> remindList = [5,10,15,20];
  String selectedRepeat = "None";
  List<String> repeatList = ["None" , "Daily" , "Weekly" , "Monthly"];
  int selectColor = 0;
  String? dropDownValue ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar:appBar(),
      body: Container(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Add Task",
              style: headingText,),
                InputField(
                controller: titleCon,
                  title: "Title",
                  hint: "Enter Title here",
              ),
              InputField(
                controller: noteCon,
                title: "Note",
                hint: "Enter Note here",
              ),
                InputField(
                title: "Date",
                hint: DateFormat.yMd().format(selectDate),
                widget:IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.calendar_today,
                  color: Colors.grey,),
                )
              ),
              Row(
                children:  [
                  Expanded(
                    child: InputField(
                      title: "Start Time",
                      hint: startTime,
                      widget:const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.access_time_rounded,
                          color: Colors.grey,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: endTime,
                      widget:const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.access_time_rounded,
                        color: Colors.grey,),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: "Remind",
                hint: "$selectRemind minutes early",
                widget:  Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton (
                    dropdownColor: Colors.blueGrey,
                    underline: Container(),
                    style: subTitleStyle,
                    value: dropDownValue,
                    icon: const Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,),
                    items:  remindList.map((item)
                    {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),),
                      );
                    }).toList(),
                    onChanged: ( newVal)
                    {
                      setState(() {
                        selectRemind = int.parse(newVal.toString());
                      });
                    },
                  ),
                ),
              ),
              InputField(
                title: "Repeat",
                hint: "$selectedRepeat ",
                widget:  Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton (
                    dropdownColor: Colors.blueGrey,
                    underline: Container(),
                    style: subTitleStyle,
                    value: dropDownValue,
                    icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,),
                    items:  repeatList.map((item)
                    {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),),
                      );
                    }).toList(),
                    onChanged: (String? newVal)
                    {
                      setState(() {
                        selectedRepeat = newVal!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  colorPalette(),
                  MyButton(
                      label: "Create Task",
                      onTap: (){},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column colorPalette()
  {
    return Column(
      children: [
        Text("Color",style: titleStyle,),
        Row(
          children:   [
            GestureDetector(
              onTap: (){
                setState(() {
                  selectColor=0;
                });
              },
              child:  Padding(
                padding:const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  child: selectColor==0?const Icon(Icons.done) : Container(),
                  radius: 15,
                  backgroundColor: primaryClr,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  selectColor=1;
                });
              },
              child:  Padding(
                padding:const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  child: selectColor==1?const Icon(Icons.done) : Container(),
                  radius: 15,
                  backgroundColor: pinkClr,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  selectColor=2;
                });
              },
              child:  Padding(
                padding:const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  child:selectColor==2?const Icon(Icons.done) : Container(),
                  radius: 15,
                  backgroundColor: orangeClr,
                ),
              ),
            ),
          ],
        ),
      ],
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
