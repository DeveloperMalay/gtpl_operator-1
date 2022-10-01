import 'package:flutter/material.dart';
import 'package:gtpl_operator/api_layer/model/get_ticket_model.dart';
import 'package:gtpl_operator/api_layer/networking.dart';
import 'package:gtpl_operator/const/const.dart';
import 'package:gtpl_operator/view/subscriber/subscreen/cable/components/service_rating.dart';

// ignore: must_be_immutable
class OperatorTicketView extends StatefulWidget {
  const OperatorTicketView({
    Key? key,
  }) : super(key: key);

  @override
  State<OperatorTicketView> createState() => _OperatorTicketViewState();
}

class _OperatorTicketViewState extends State<OperatorTicketView> {
  // Initial Selected Value
  String dropdownvalue = 'pending';
  final List<String> _items = ['pending', 'in-progress'];

  late Future<List<GetTicket>> futureData;

  late Future<List<GetTicket>> searchData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    futureData = fetchTicketData();
    super.initState();
  }

  // void _runFilter(String enteredKeyword) async {
  //   if (enteredKeyword.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     searchData = fetchTicketData();
  //   } else {
  //    // searchData = await searchApi.fetchTicketData().then((value) =>
  //       //  value?.where((data) => data.userId.contains(enteredKeyword)));
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }

  //   // Refresh the UI
  //   setState(() {
  //     futureData = searchData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetTicket>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetTicket>? data = snapshot.data;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data!.length,
              itemBuilder: (context, index) {
                var str = data[index].createdAt.toString();
                var parts = str.split(' ');
                var createdDate = parts[0].trim();
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 23,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greyColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].issueType,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                'Subscriber Id - ${data[index].userId}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: data[index].isclosed == 0
                                  ? greenColor
                                  : redColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              data[index].isclosed == 0
                                  ? data[index].status
                                  : "closed",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: greyColor),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 16,
                                  child: Container(
                                    height: 400.0,
                                    width: 360.0,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].issueType,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "date: $createdDate",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'TK No. ${data[index].id}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Ticket Details :',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            child: ListView(
                                              children: [
                                                Text(data[index].description)
                                              ],
                                            ),
                                          ),
                                        ),
                                        StarRating(
                                          ticketId: data[index].id,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // DropdownButton(
                                            //   // Initial Value
                                            //   value: dropdownvalue,

                                            //   // Down Arrow Icon
                                            //   icon: const Icon(
                                            //       Icons.keyboard_arrow_down),
                                            //   items: _items.map((String items) {
                                            //     return DropdownMenuItem<String>(
                                            //       value: items,
                                            //       child: Text(items),
                                            //     );
                                            //   }).toList(),
                                            //   onChanged: (String? newValue) {
                                            //     // setState(() {
                                            //     //   dropdownvalue = newValue!;
                                            //     // });
                                            //   },
                                            // ),

                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: whiteColor,
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: InkWell(
                                                onTap: () {
                                                  updateTicket(
                                                    data[index].id,
                                                  );
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        Future.delayed(
                                                            const Duration(
                                                              seconds: 1,
                                                            ), () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        });
                                                        return AlertDialog(
                                                          content: SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: Center(
                                                              child: Text(
                                                                'You changed the ticket status to in-process',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                  setState(() {
                                                    futureData =
                                                        fetchTicketData();
                                                  });
                                                  Future.delayed(
                                                      const Duration(
                                                        seconds: 1,
                                                      ), () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  });
                                                },
                                                child: Text(
                                                  'Change status',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Request Admin',
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'View details',
                            style: TextStyle(
                              color: greyColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
