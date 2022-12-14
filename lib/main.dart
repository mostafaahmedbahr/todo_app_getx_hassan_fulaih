import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_app_getx_hassan_fulaih/services/notification_services.dart';
import 'package:todo_app_getx_hassan_fulaih/services/theme_services.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/pages/notification_screen.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/theme.dart';

import 'ui/pages/home_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotifyHelper().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Flutter Demo',
      theme:  Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      // ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home:const  HomePage(),
    );
  }
}
