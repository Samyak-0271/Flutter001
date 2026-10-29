import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Home(),
  ));
}
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final List<Map<String,String>> items = [{'name': 'India', 'timezone': 'Asia/Kolkata'},
//     {'name': 'USA', 'timezone': 'America/New_York'},
//     {'name': 'UK', 'timezone': 'Europe/London'},
//     {'name': 'Australia', 'timezone': 'Australia/Sydney'},
//     {'name': 'Japan','timezone':'Asia/Tokyo'},
//     {'name':'UAE','timezone':'Asia/Dubai'},
//     {'name':'Singapore','timezone':'Asia/Singapore'},
//     {'name':'Canada','timezone':'America/Toronto'},
//     {'name': 'Germany', 'timezone': 'Europe/Berlin'},
//     {'name': 'Brazil', 'timezone': 'America/Sao_Paulo'},
//     {'name': 'South Africa', 'timezone': 'Africa/Johannesburg'},
//     {'name': 'New Zealand', 'timezone': 'Pacific/Auckland'},];
//   String dateTime = '';
//   String selectedCountry = '';
//   bool loading = false;
//   String error = '';
//
//   Future<void> getTime(String country, String timezone) async {
//     setState(() {
//       selectedCountry = country;
//       loading = true;
//       error = '';
//       dateTime = '';
//     });
//
//     try {
//       final url = Uri.https(
//         'timeapi.io',
//         '/api/Time/current/zone',
//         {'timeZone': timezone},
//       );
//
//       final response = await http.get(url);
//
//       if (response.statusCode != 200) {
//         throw Exception('Status: ${response.statusCode}');
//       }
//
//       final data = jsonDecode(response.body);
//
//       if (data['timeZone'] != timezone) {
//         throw Exception('Unexpected timezone in API response');
//       }
//
//       if (!mounted) return;
//
//       setState(() {
//         dateTime =
//         '${data['date']}\n'
//             '${data['time']}\n'
//             '${data['timeZone']}';
//
//         loading = false;
//       });
//     } catch (e) {
//       debugPrint('World time API error: $e');
//
//       if (!mounted) return;
//
//       setState(() {
//         error = 'Could not fetch time. Check the API or connection.';
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('World Clock'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           if (selectedCountry.isNotEmpty)
//             Card(
//               margin: const EdgeInsets.all(12),
//               child: ListTile(
//                 title: Text(
//                   selectedCountry,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 subtitle: loading
//                     ? const Text('Fetching date and time...')
//                     : Text(
//                   error.isNotEmpty
//                       ? error
//                       : dateTime,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 trailing: loading
//                     ? const CircularProgressIndicator()
//                     : const Icon(Icons.access_time),
//               ),
//             ),
//           const Divider(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final country = items[index];
//
//                 return ListTile(
//                   leading: CircleAvatar(
//                     child: Text(country['name']![0]),
//                   ),
//                   title: Text(country['name']!),
//                   subtitle: Text(country['timezone']!),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: () => getTime(
//                     country['name']!,
//                     country['timezone']!,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }