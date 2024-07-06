import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/postcontroller.dart';

class TextInputBoxOnly extends StatefulWidget {
  final String title;
  final String hintText;

  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;

  final double widthh;

  const TextInputBoxOnly({
    super.key,
    required this.title,
    required this.hintText,
    required this.textType,
    required this.topPadding,
    required this.controller,
    required this.widthh,
  });

  @override
  State<TextInputBoxOnly> createState() => _TextInputBoxOnlyState();
}

class _TextInputBoxOnlyState extends State<TextInputBoxOnly> {
  PostController postController = Get.find();
  var textstyle = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Colors.black.withOpacity(0.5),
    height: 1.2,
    fontSize: 16,
    // letterSpacing: 1,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    // letterSpacing: 1,
    color: Colors.black.withOpacity(0.5),
  );
  var iconColorChange = false;
  getBorderColor() {
    if (widget.controller == postController.number) {
      return postController.flagActiveFlag.value
          ? postController.numberFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: TextStyle(
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF2F3F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: getBorderColor(),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 48,
                width: (Get.width / widget.widthh),
                child: Focus(
                  onFocusChange: (val) {
                    setState(() {
                      val ? iconColorChange = true : iconColorChange = false;
                    });
                  },
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    cursorHeight: 24,
                    cursorWidth: 1.8,
                    cursorRadius: const Radius.circular(10),
                    controller: widget.controller,
                    textInputAction: TextInputAction.done,
                    keyboardType: widget.textType,
                    maxLines: 1,
                    // maxLength: widget.numberLength,
                    cursorColor: Colors.black,
                    style: textstyle,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      hintText: widget.hintText,
                      hintStyle: textstyleh,
                    ),
                    onChanged: (val) {
                      // postController.alltextfield();
                      if (val != '') {
                        // postController.istitletxt.value == true;
                        // widget.flag = true;
                        // postController.page2chack();
                      }
                      // postController.allCategoryCheck();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
