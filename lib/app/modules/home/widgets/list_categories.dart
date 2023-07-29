import 'package:flutter/material.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/themes/theme.dart';

class ListCategory extends StatelessWidget {
  ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RoundedContainer(
            gradient: RadialGradient(
              colors: [
                ThemeApp.primaryColor.withOpacity(0.1),
                ThemeApp.primaryColor.withOpacity(0.1),
                ThemeApp.primaryColor.withOpacity(0.3),
                ThemeApp.primaryColor.withOpacity(0.5),
              ],
            ),
            hasBorder: true,
            borderColor: Colors.grey[300],
            width: 70,
            height: 65,
            child: Center(
              child: Image.asset(
                'assets/content/${categories[index]['image']}',
                width: 30,
                height: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> categories = [
    {
      'name': 'Apel',
      'image': 'apple.png',
    },
    {
      'name': 'Brokoli',
      'image': 'broccoli.png',
    },
    {
      'name': 'Pisang',
      'image': 'banana.png',
    },
    {
      'name': 'Cabai',
      'image': 'chilli.png',
    },
    {
      'name': 'Wortel',
      'image': 'carrot.png',
    },
    {
      'name': 'Semangka',
      'image': 'watermelon.png',
    }
  ];
}
