import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:evently/screens/add_event/add_event_screen.dart';
import 'package:evently/screens/add_event/chip_item.dart';
import 'package:evently/screens/home/tabs/events_tab.dart';
import 'package:evently/screens/home/tabs/fav_tab.dart';
import 'package:evently/screens/home/tabs/map_tab.dart';
import 'package:evently/screens/home/tabs/profile_tab.dart';
import 'package:evently/screens/register/login_screen.dart';
import 'package:evently/providers/app_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedCategoryIndex = 0;

  List<String> categories = [
    "All",
    "meeting",
    "holiday",
    "workshop",
    "sport",
    "book_club",
    "eating",
    "birthday",
    "gaming",
    "exhibition"
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final tabs = [
      EventsTab(category: categories[selectedCategoryIndex]),
      const MapTab(),
      const FavTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(appProvider),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(),
      body: tabs[selectedIndex],
    );
  }

  AppBar _buildAppBar(AppProvider appProvider) {
    return AppBar(
      centerTitle: false,
      toolbarHeight: 174,
      backgroundColor: const Color(0xFF5669FF),
      shape: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      leadingWidth: 0,
      leading: const SizedBox(),
      actions: [
        Column(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.sunny)),
            Container(
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF5669FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("EN"),
              ),
            ),
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back ✨",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            appProvider.userModel?.username ?? "",
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white),
              Text(
                "Cairo, Egypt",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: categories.length,
              itemBuilder: (_, index) {
                return ChipItem(
                  title: categories[index],
                  isSelected: selectedCategoryIndex == index,
                  bg: selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.transparent,
                  textColor: selectedCategoryIndex == index
                      ? const Color(0xFF5669FF)
                      : Colors.white,
                  borderColor: Colors.white,
                  onTap: () {
                    setState(() => selectedCategoryIndex = index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.pushNamed(context, AddEventScreen.routeName);
        if (result == true) {
          setState(() {}); // Refresh home screen after adding event
        }
      },
      backgroundColor: const Color(0xFF5669FF),
      child: const Icon(Icons.add, size: 45, color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: const BorderSide(color: Colors.white, width: 4),
      ),
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      color: const Color(0xFF5669FF),
      padding: EdgeInsets.zero,
      notchMargin: 12,
      shape: const CircularNotchedRectangle(),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
