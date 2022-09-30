import 'package:flutter/material.dart';
import 'package:gtpl_operator/api_layer/model/get_ticket_model.dart';
import 'package:gtpl_operator/api_layer/networking.dart';
import 'package:gtpl_operator/const/const.dart';

class Ticket extends StatefulWidget {
  const Ticket({
    Key? key,
  }) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  // Initial Selected Value
  String dropdownvalue = '';
  final List<String> _items = ['pending', 'in-progress'];
  late Future<List<GetTicket>> futureData;
  Iterable<GetTicket> searchResult = [];

  List<GetTicket> ticketDetails = [];

  @override
  void initState() {
    futureData = fetchTicketData();
    // fetchTicketData().then((data) {
    //   setState(() {
    //     ticketDetails = searchResult = data;
    //   });
    // });
    super.initState();
  }

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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "issue: ${data[index].issueType}",
                                  // widget.issueTitle,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " Status: ${data[index].status}",
                                  //'TK No. 123456',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " TK No. ${data[index].id}",
                                  //'TK No. 123456',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              createdDate,
                              //  '12/10/21',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                data[index].description,
                                //'Subscriber #1234556 raised a issue for "website not opening" ',
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: greyColor,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.phone_forwarded_outlined,
                                color: greenColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
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
                                                Text(
                                                  "Tk No. ${data[index].id}",
                                                  // 'TK No. 123456',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              createdDate,
                                              //'12/10/21',
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
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
                                                Text(data[index].description),
                                              ],
                                            ),
                                          ),
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

                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
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
                                                        ));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primaryColor),
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  'Change Status',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 16,
                                                  ),
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
                                              child: Text(
                                                'Request Admin',
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 16,
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'view',
                              style: TextStyle(color: whiteColor, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
