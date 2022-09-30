import 'package:flutter/material.dart';
import 'package:gtpl_operator/api_layer/networking.dart';
import 'package:gtpl_operator/const/const.dart';
import 'package:gtpl_operator/view/home/components/reminder.dart';
import 'package:gtpl_operator/view/home/components/slider.dart';
import 'package:gtpl_operator/view/home/components/ticket.dart';
import 'package:gtpl_operator/view/myaccount/manage%20tickets/manage_tickets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getToken();
    fetchTicketData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 70,
              left: 35,
              right: 35,
              bottom: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,xyz',
                      style: TextStyle(
                        fontSize: 20,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Operator Id:252621',
                      style: TextStyle(
                        fontSize: 12,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 75,
                ),
                Icon(
                  Icons.notifications_none_outlined,
                  color: primaryColor,
                  size: 30,
                ),
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: primaryColor,
                  size: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: whiteColor,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'You are Operating in ',
                  style: TextStyle(
                    fontSize: 16,
                    color: whiteColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  child: Text(
                    'Phoolbagan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23.0),
                  child: Text(
                    'Tickets :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 420,
                  width: 450,
                  child: const Ticket(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const ManageTicket(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: greyColor,
                          ),
                        )),
                        child: Text(
                          'show all',
                          style: TextStyle(
                            color: greyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const CustomSlider(),
          const Reminder(),
          const Reminder(),
          const Reminder(),
        ],
      ),
    );
  }
}
