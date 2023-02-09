import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class AttendBottomSheet extends StatefulWidget {
  const AttendBottomSheet({super.key});

  @override
  State<AttendBottomSheet> createState() => _AttendBottomSheetState();
}

class _AttendBottomSheetState extends State<AttendBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hi,'),
                Text('Aswin'),
              ],
            ),
          ),
          ActionSlider.standard(
            boxShadow: const [],
            toggleColor: Colors.white,
            backgroundColor: Colors.blue,
            action: (controller) async {
              controller.loading();
              await Future.delayed(const Duration(seconds: 2));
              controller.success();
              await Future.delayed(const Duration(seconds: 1));
              controller.reset();
            },
            child: const Text(
              'Slide to confirm',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
