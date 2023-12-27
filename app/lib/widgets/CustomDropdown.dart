import 'package:app/providers/CurrentRankProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyCustomDropdown extends StatelessWidget {
  const MyCustomDropdown({super.key});
  @override
  Widget build(BuildContext context) {
    int startIndex = context.watch<CurrentRank>().index;
    final double screenWidth = MediaQuery.of(context).size.width;
    return PopupMenuButton<String>(
        child: Container(
          width: screenWidth * 0.3 > 300 ? 300 : screenWidth * 0.3,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ranks[startIndex][2], ranks[startIndex][3]],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                ranks[startIndex][1],
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
        onSelected: (String newValue) {
          print("Selected:" + newValue);
          /*setState(() {
          dropdownValue = newValue;
        });*/
          context.read<CurrentRank>().changeIndex(int.parse(newValue));
        },
        itemBuilder: (BuildContext context) {
          return ranks.asMap().entries.map((entry) {
            int index = entry.key;
            List<dynamic> currentEntry = entry.value;
            return PopupMenuItem<String>(
              value: index.toString(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      currentEntry[2],
                      currentEntry[3]
                    ], // Replace with desired colors or logic
                  ),
                ),
                child: ListTile(
                  title: Text(currentEntry[1],
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            );
          }).toList();
        });
  }
}
