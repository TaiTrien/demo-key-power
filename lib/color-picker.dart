import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  List<int> colorsCode = [0xFF173F5F, 0xFF20639B, 0xFF3CAEA3, 0xFFF6D55C, 0xFFED553B];
  int currentColor;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Color picker'),
      ),
      body: Container(
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: colorsCode.length,
                  itemBuilder: (context, index) {
                    return Draggable<int>(
                      key: UniqueKey(),
                      data: colorsCode[index],
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 80,
                        width: 80,
                        color: Color(colorsCode[index]),
                      ),
                      feedback: Container(
                        padding: EdgeInsets.all(10),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Color(colorsCode[index]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      childWhenDragging: Container(
                        padding: EdgeInsets.all(10),
                        height: 80,
                        width: 80,
                        color: Color(colorsCode[index]).withOpacity(0.3),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 10);
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              DragTarget<int>(
                onWillAccept: (color) {
                  return true;
                },
                onAccept: (color) {
                  setState(() {
                    currentColor = color;
                  });
                },
                builder: (BuildContext context, List<int> acceptColor, List<dynamic> rejectedData) {
                  return currentColor == null
                      ? DottedContainer()
                      : AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 200,
                          width: 200,
                          curve: Curves.fastOutSlowIn,
                          color: Color(currentColor),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DottedContainer extends StatelessWidget {
  const DottedContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        child: Container(
      height: 200,
      width: 200,
    ));
  }
}
