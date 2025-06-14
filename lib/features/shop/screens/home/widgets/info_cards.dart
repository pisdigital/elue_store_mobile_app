import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoCards extends StatelessWidget {
  const InfoCards({super.key, required this.title, required this.icon});
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // width: MediaQuery.of(context).size.width - 80,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0XFF024B59)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  icon,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
