import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/screens/add_event/chip_item.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "AddEventScreen";

  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedCategoryIndex = 0;

  var titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var descriptionController = TextEditingController();
  List<String> categories = [
    "meeting",
    "holiday",
    "workshop",
    "sport",
    "book_club",
    "eating",
    "birthday",
    "gaming",
    "exhibition",
  ];

  final Color primaryColor = const Color(0xFF5669FF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: primaryColor)),
        title: Text(
          "Create Event",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                "assets/images/${categories[selectedCategoryIndex]}.png",
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChipItem(
                    bg: selectedCategoryIndex == index ? primaryColor : Colors.transparent,
                    textColor: selectedCategoryIndex == index ? Colors.white : primaryColor,
                    borderColor: primaryColor,
                    title: categories[index],
                    isSelected: selectedCategoryIndex == index,
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                  );
                },
                itemCount: categories.length,
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: titleController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: textColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: descriptionController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: textColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date",
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                GestureDetector(
                  onTap: selectTaskDate,
                  child: Text(
                    selectedDate.toString().substring(0, 10),
                    style: TextStyle(fontSize: 18, color: primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  TaskModel model = TaskModel(
                    title: titleController.text,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    description: descriptionController.text,
                    category: categories[selectedCategoryIndex],
                    date: selectedDate.millisecondsSinceEpoch,
                  );
                  FirebaseManager.createEvent(model);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Create Event",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectTaskDate() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
