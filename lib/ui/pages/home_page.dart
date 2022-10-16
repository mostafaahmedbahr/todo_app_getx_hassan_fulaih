import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
 import 'package:todo_app_getx_hassan_fulaih/ui/pages/add_task_page.dart';
 import 'package:todo_app_getx_hassan_fulaih/ui/size_config.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/widgets/button.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/widgets/task_tile.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskCon = Get.put(TaskController());
  var selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    NotifyHelper().initializeNotification();
    NotifyHelper().requestIosPermission();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addTaskBar(),
            addDateBar(),
            const SizedBox(height: 6,),
            showTasks(
                Task(
                  color: 0,
                  note: "note 1",
                  title: "title 1",
                  isCompleted: 0,
                  startTime: "2:50",
                  endTime: "3:50",
                ),
            ),

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
          ThemeServices().switchTheme();
          NotifyHelper().displayNotifications(title: "title", body: "body");
          NotifyHelper().scheduledNotification();
        },
        icon:  Icon(Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 24,
          color:Get.isDarkMode ? Colors.white :  darkGreyClr,),
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

  addTaskBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingText,),
              Text("Today",
              style: subHeadingText,),
            ],
          ),
          MyButton(
            onTap: ()async
            {
             await Get.to(()=>const AddTaskPage());
             taskCon.getAllTasks();
            },
            label: "+ Add Task",
          ),
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6,left: 20),
      child: DatePicker(
        selectedDate,
        initialSelectedDate: selectedDate,
        height: 100,
        width: 70,
        selectedTextColor: Colors.white,
        deactivatedColor: Colors.green,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle:const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        onDateChange: (newDate)
        {
          setState(() {
            selectedDate == newDate;
          });
        },
      ),
    );
  }

  showTasks(Task task) {
    return  GestureDetector(
      onTap: (){
        showModalBottomSheet(context: context,
          isScrollControlled: true,
          builder: (context)
          {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  task.isCompleted == 1 ? Container():   buildBottomSheet(
                    color: primaryClr,
                    label: "Task Completed",
                    onTap: (){},
                  ),
                  buildBottomSheet(
                    color: primaryClr,
                    label: "Delete Task",
                    onTap: (){},
                  ),
                    Divider(
                    color:Get.isDarkMode?  Colors.grey : darkHeaderClr,
                  ),
                  buildBottomSheet(
                    color: primaryClr,
                    label: "Cancel",
                    onTap: (){
                      Get.back();
                    },
                  ),

                ],
              ),
            );
          },
        );
      },
      child: TaskTile(task: Task(
        color: 0,
        note: "note 1",
        title: "title 1",
        isCompleted: 0,
        startTime: "2:50",
        endTime: "3:50",
      ) ),
    );
  }

  noTasks()
  {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(

            direction: Axis.horizontal,
            children: [

              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: SvgPicture.asset("assets/images/task.svg",
                    height: 90,
                    semanticsLabel: "Task",
                    color: primaryClr.withOpacity(0.5),
                  ),
                ),
              ),

              Center(
                child: Text("You don\' have any task yet",
                  style: subTitleStyle,
                  textAlign: TextAlign.center,),
              ) ,

            ],
          ),
        ),
      ],
    );
  }

  buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color color,
    bool isClose = false,
})
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth *0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : color,
          border: Border.all(
            width: 2,
            color:isClose?
             Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]!
                : color
          ),
        ),
        child: Center(
          child: Text(label,
          style: isClose ? titleStyle : titleStyle.copyWith(
            color: Colors.white,
          ), ),
        ),
      ),
    );
  }

  // showBottomSheet(BuildContext context , Task task)
  // {
  //   Get.bottomSheet(
  //     SingleChildScrollView(
  //       child: Container(
  //         padding: const EdgeInsets.only(top: 4),
  //         width: SizeConfig.screenWidth,
  //         color: Get.isDarkMode ? darkHeaderClr : Colors.white,
  //         child: Column(
  //           children: [
  //             Flexible(child: Container(
  //               height: 6,
  //               width: 120,
  //               decoration: BoxDecoration(
  //                 color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //
  //             )),
  //             const SizedBox(height: 20,),
  //             task.isCompleted == 1 ?  Container() : buildBottomSheet(
  //                 label: "Task Completed",
  //                 onTap: (){},
  //                 color: primaryClr,
  //             ),
  //             buildBottomSheet(
  //               label: "Delete Task",
  //               onTap: (){},
  //               color: primaryClr,
  //             ),
  //             Divider(
  //               color:Get.isDarkMode ?  Colors.grey : darkGreyClr,
  //             ),
  //             buildBottomSheet(
  //               label: "Cancel",
  //               onTap: (){
  //                 Get.back();
  //               },
  //               color: primaryClr,
  //             ),
  //             const SizedBox(height: 20,),
  //           ],
  //         ),
  //       ),
  //     ),
  //
  //   );
  // }
}
