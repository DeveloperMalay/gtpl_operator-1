import 'package:flutter/material.dart';
import 'package:gtpl_operator/api_layer/networking.dart';
import 'package:gtpl_operator/const/const.dart';
import 'package:gtpl_operator/view/home/home_screen.dart';
import 'package:gtpl_operator/view/myaccount/myaccount.dart';
import 'package:gtpl_operator/view/subscriber/subscreen/cable/components/subscreen/demo_ticket.dart';
import 'package:gtpl_operator/view/subscriber/subscreen/subscriberDetails/subscriber_details.dart';
import 'package:gtpl_operator/view/subscriber/subscriber.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> currentWidget = [
    const HomeScreen(),
    const SubscriberDetails(),
    // const Search(),
    // const Text(
    //   'help',
    //   style: TextStyle(color: Colors.black),
    // ),
    const Subscriber(),
    const MyAccount()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWidget[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              size: 35,
              color: primaryColor,
            ),
            icon: Icon(
              Icons.home_outlined,
              size: 35,
              color: primaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.help,
              size: 35,
              color: primaryColor,
            ),
            icon: Icon(
              Icons.help_outline,
              size: 35,
              color: primaryColor,
            ),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.people,
              size: 35,
              color: primaryColor,
            ),
            icon: Icon(
              Icons.people_outline,
              size: 35,
              color: primaryColor,
            ),
            label: 'Subscriber',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              size: 35,
              color: primaryColor,
            ),
            icon: Icon(
              Icons.person_outline,
              color: primaryColor,
              size: 35,
            ),
            label: 'My Account',
          ),
        ],
      ),
    );
  }
}
