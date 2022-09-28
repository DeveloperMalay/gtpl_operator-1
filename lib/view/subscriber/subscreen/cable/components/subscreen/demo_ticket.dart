// main.dart
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}






















// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:gtpl_operator/api_layer/model/get_ticket_model.dart';
// import 'package:gtpl_operator/api_layer/networking.dart';
// import 'package:gtpl_operator/const/const.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   List<GetTicket> tickets = [];
//   String query = "";
//   final TextEditingController _searchController = TextEditingController();
//   Timer? debouncer;

//   @override
//   void initState() {
//     init();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     debouncer?.cancel();
//     super.dispose();
//   }

//   void debounce(VoidCallback callback,
//       {Duration duration = const Duration(milliseconds: 1000)}) {
//     if (debouncer != null) {
//       debouncer!.cancel();
//     }

//     debouncer = Timer(duration, callback);
//   }

//   Future init() async {
//     final tickets = await SearchApi.getTickets(query);
//     setState(
//       () => this.tickets = tickets,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
//       child: SafeArea(
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: () {},
//                 ),
//                 hintText: 'Search by Id',
//                 border: const OutlineInputBorder(),
//               ),
//               onChanged: searchTicket,
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: tickets.length,
//                   itemBuilder: (context, index) {
//                     final ticket = tickets[index];
//                     return buildTicket(ticket);
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTicket(GetTicket ticket) {
//     return Container(
//         color: primaryColor,
//         height: 100,
//         width: 300,
//         padding: const EdgeInsets.all(9),
//         child: ListTile(
//           title: Text(ticket.userId),
//           subtitle: Text(ticket.description),
//         ));
//   }

//   void searchTicket(String query) async => debounce(() async {
//         final tickets = await SearchApi.getTickets(query);
//         if (!mounted) return;
//         setState(() {
//           this.query = query;
//           this.tickets = tickets;
//         });
//       });
// }
