import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashWidth = 10.0;
        const gapSize = 1.0;
        final constrainWidth = constraints.constrainWidth();
        final dashCount = (constrainWidth / (2 * dashWidth)).round();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: gapSize,
              child: ColoredBox(
                color: Colors.blue,
              ),
            );
          }),
        );
      },
    );
  }
}
