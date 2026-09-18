import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/ui/home/tabs/favorite/favorite_tab.dart';
import 'package:final_project/ui/home/tabs/home/home_tab.dart';
import 'package:final_project/ui/home/tabs/profiles/profile_tab.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [HomeTab(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          _builtBottomNavBaritem(
            selectedIconName: Icons.home_rounded,
            unSelectedIconName: Icons.home_outlined,
            label: AppLocalizations.of(context)!.home,
            isSelected: selectedIndex == 0,
          ),
          _builtBottomNavBaritem(
            selectedIconName: Icons.favorite_rounded,
            unSelectedIconName: Icons.favorite_outlined,
            label: AppLocalizations.of(context)!.favorite,
            isSelected: selectedIndex == 1,
          ),
          _builtBottomNavBaritem(
            selectedIconName: Icons.person,
            unSelectedIconName: Icons.person_2_outlined,
            label: AppLocalizations.of(context)!.profile,
            isSelected: selectedIndex == 2,
          ),
        ],
      ),
      body: tabsList[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo navigate to add event screen
        },
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 25),
      ),
    );
  }

  BottomNavigationBarItem _builtBottomNavBaritem({
    required IconData selectedIconName,
    required IconData unSelectedIconName,
    required String label,
    required isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(isSelected ? selectedIconName : unSelectedIconName),
      label: label,
    );
  }
}
