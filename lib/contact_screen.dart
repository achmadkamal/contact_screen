import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List contacts = [];

  @override
  void initState() {
    super.initState();
    getContact();
  }

  Future getContact() async {
    String url = 'https://reqres.in/api/users?per_page=12';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data'];
      setState(() {
        contacts = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'CONTACT',
        ),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: contactList(),
    );
  }

  Widget contactList() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return contactCard(contacts[index]);
      },
    );
  }

  Widget contactCard(item) {
    var fullName = item['first_name'] + " " + item['last_name'];
    var email = item['email'];
    var picture = item['avatar'];
    return Card(
      child: ListTile(
        leading: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(picture),
            ),
          ),
        ),
        title: Text(
          fullName.toString(),
        ),
        subtitle: Text(
          email.toString(),
        ),
        trailing: Wrap(
          spacing: 10.0,
          children: <Widget>[
            Icon(Icons.phone),
            Icon(Icons.message),
          ],
        ),
      ),
    );
  }
}
