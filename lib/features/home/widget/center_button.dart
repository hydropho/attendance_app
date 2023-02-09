import 'package:flutter/material.dart';

import '../../../config/location_service.dart';

class CenterButton extends StatelessWidget {
  const CenterButton({super.key});

  void showMsgDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            content,
            style: const TextStyle(height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LocationService().getDistance.then((value) {
          if (value <= 300) {
            showMsgDialog(context, 'Berhasil!', 'Absensi masuk berhasil!');
          } else {
            showMsgDialog(context, 'Gagal!', 'Absensi masuk gagal!');
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ]),
        child: const Text(
          'Masuk',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
