import 'package:first/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedComponent extends StatefulWidget {
  final String text;
  final bool isChecked;

  const DottedComponent({
    Key? key,
    required this.text,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<DottedComponent> createState() => _TestComponent();
}

class _TestComponent extends State<DottedComponent> {
  TextEditingController controller = TextEditingController();
  final List<double> _dropdownValues = [100, 200, 300, 400];

  double dottedWidth = 100;
  double initWidgetWidth = 400;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(updateWidth);
  }

  void updateWidth() {
    setState(() {
      initWidgetWidth = double.tryParse(controller.text) ?? 400;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              child: DropdownButtonFormField<double>(
                value: initWidgetWidth,
                onChanged: (newValue) {
                  setState(() {
                    initWidgetWidth = newValue!;
                    controller.text = initWidgetWidth.toString();
                    dottedWidth = initWidgetWidth;
                  });
                },
                items: _dropdownValues.map((value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: initWidgetWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: dottedWidth > 10 ? 0 : 1,
                  child: Text(
                    widget.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                dottedWidth > 10
                    ? Expanded(
                        child: LayoutBuilder(
                          builder: (
                            BuildContext context,
                            BoxConstraints constraints,
                          ) {
                            final newWidth = constraints.maxWidth / 2;
                            if (newWidth != dottedWidth ) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {
                                  dottedWidth = newWidth;
                                });
                              });
                            }
                            return const DottedLine();
                          },
                        ),
                      )
                    : const SizedBox(),
                Checkbox(
                  value: widget.isChecked,
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
