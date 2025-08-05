import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/firebase/firebase_manager.dart';

class EventsTab extends StatelessWidget {
  final String category;

  EventsTab({super.key, required this.category});

  static const Color highlightColor = Color(0xFF5669FF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundCardColor = isDark ? Colors.grey[800] : const Color(0xFFF2FEFF);
    final textColor = isDark ? Colors.white : Colors.black;

    return StreamBuilder(
      stream: FirebaseManager.getTasks(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: highlightColor));
        }
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong".tr()));
        }
        if (snapshot.data?.docs.isEmpty ?? true) {
          return Center(child: Text("No Tasks".tr()));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: snapshot.data?.docs.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = snapshot.data!.docs[index].data();
              final taskDate = DateTime.fromMillisecondsSinceEpoch(task.date ?? 0);

              return Container(
                height: 203,
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${task.category}.png"),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: backgroundCardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        children: [
                          Text(
                            taskDate.day.toString().padLeft(2, '0'),
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: highlightColor,
                            ),
                          ),
                          Text(
                            DateFormat('MMM').format(taskDate),
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: highlightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundCardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          task.title ?? "",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        trailing: const Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
