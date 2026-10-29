import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState()  => _HomeState();
}
class _HomeState extends State<Home>{
  final List<Map<String,String>> items = [{'name': 'India', 'timezone': 'Asia/Kolkata'},
    {'name': 'USA', 'timezone': 'America/New_York'},
    {'name': 'UK', 'timezone': 'Europe/London'},
    {'name': 'Australia', 'timezone': 'Australia/Sydney'},
    {'name': 'Japan','timezone':'Asia/Tokyo'},
    {'name':'UAE','timezone':'Asia/Dubai'},
    {'name':'Singapore','timezone':'Asia/Singapore'},
    {'name':'Canada','timezone':'America/Toronto'},
    {'name': 'Germany', 'timezone': 'Europe/Berlin'},
    {'name': 'Brazil', 'timezone': 'America/Sao_Paulo'},
    {'name': 'South Africa', 'timezone': 'Africa/Johannesburg'},
    {'name': 'New Zealand', 'timezone': 'Pacific/Auckland'},];
  String datetime ='';
  String country = '';
  String error = '';
  bool loading = false;
  Future<void> getTime(String country,String timezone) async{
    setState(() {
      country = country;
      loading = true;
      error = '';
      datetime = '';
    });
    try{
      final url = Uri.https( 'timeapi.io',
        '/api/Time/current/zone',
        {'timeZone': timezone},);
      final response = await http.get(url);
      if(response.statusCode != 200){
        throw Exception('Status ${response.statusCode}');
      }
      final data = jsonDecode(response.body);
      if(data['timezone'] != timezone){
        throw Exception("Unknown error from api");
      }
      if(!mounted) return;
      setState(() {
        datetime = '${data['date']}\n${data['time']}\n${data['timezone']}';
        loading = true;
      });
    }
    catch(e){
      debugPrint('World time api error $e');
      if(!mounted) return;
      setState(() {
        error = 'Could not fetch time';
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("App BAr of clock "),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          if (country.isNotEmpty)
            Card(
              margin: const EdgeInsets.all(12),
              child:ListTile(
                title: Text(
                  country,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                  ),
                ),
                subtitle: loading?const Text('Fetching date time'):Text(
                  error.isNotEmpty?error:datetime,
                  style:const TextStyle(fontSize: 18),
                ),
                trailing: loading ? const CircularProgressIndicator() : const Icon(Icons.access_time),
              )
            ),
          const Divider(),
          Expanded(child: ListView.builder(itemCount:items.length,
          itemBuilder:(context,index){
            final countryy = items[index];
            return ListTile(
              leading:CircleAvatar(
                child:Text(countryy['name']![0]),
              ),
                title:Text(countryy['name']!),
            subtitle:Text(countryy['timezone']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap:()=> getTime(
                countryy['name']!,countryy['timezone']!
              ),
            );
          },))
        ],
      ),
    );
  }
}