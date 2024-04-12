import 'package:flutter/material.dart';
import 'package:myapp/screens/all_songs_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            'assets/images/logo.png',
            height: 60,
            fit: BoxFit.fill,
          ),
        ),
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.blue, // dark purple
              Colors.red,
              Colors.pink // red
            ],
          ).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AudioBliss',
                style: TextStyle(fontSize: 25, fontFamily: 'Main Font'),
              ),
              Text(
                "Unleash Your Soundtrack",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito Regular',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: const AllSongsScreen(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.transparent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 1.0,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.blue, 
                Colors.red,
                Colors.pink 
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildTabItem(
                  0,
                  Image.asset(
                    'assets/images/house.png',
                    height: 30,
                  ),
                  'Home'),
              buildTabItem(
                  1,
                  Image.asset(
                    'assets/images/search.png',
                    height: 30,
                  ),
                  'Search'),
              const SizedBox(width: 48),
              buildTabItem(
                  3,
                  Image.asset(
                    'assets/images/notification.png',
                    height: 30,
                  ),
                  'Notification'),
              buildTabItem(
                  4,
                  Image.asset(
                    'assets/images/account.png',
                    height: 30,
                  ),
                  'Account'),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink,
                Colors.blue,
                Colors.red,
              ]),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildTabItem(int index, Widget icon, String text) {
    final isSelected = _selectedIndex == index;
    return Column(
      children: [
        IconButton(
          style: ButtonStyle(
              shape: const MaterialStatePropertyAll(CircleBorder()),
              backgroundColor: isSelected
                  ? MaterialStatePropertyAll(Colors.white.withOpacity(0.7))
                  : const MaterialStatePropertyAll(Colors.transparent)),
          iconSize: isSelected && index == 2 ? 45 : 40,
          icon: icon,
          color: isSelected ? Colors.white : Colors.grey,
          onPressed: () => setState(() {
            _selectedIndex = index;
          }),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: isSelected ? 18 : 16,
              fontFamily: 'Nunito Regular',
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.yellow : Colors.white),
        ),
      ],
    );
  }
}
