import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx_hassan_fulaih/ui/size_config.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.controller,
      required this.title,
      required this.hint,
      this.widget})
      : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hint;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.only(left: 8),
            margin: const EdgeInsets.only(
              top: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    readOnly:widget == null ? false : true,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         width: 0,
                         color:context.theme.backgroundColor,
                       ),
                     ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color:  context.theme.backgroundColor,
                        ),
                      ),

                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
