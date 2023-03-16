import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/transaction/transaction.dart';



class FlutterContactsExample extends StatefulWidget {
  const FlutterContactsExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(

          body: _body()));

  Widget _body() {
    if (_permissionDenied) return const Center(child: Text('Permission denied'));
    if (_contacts == null) return const Center(child:  CircularProgressIndicator());
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: Style.customGeadient(color: Style.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),

            child: ListTile(
                title: Text(_contacts![i].displayName,style: Style.primaryText(size: 16,textColor: Style.whiteColor),),
                onTap: () async {
                  final fullContact =
                  await FlutterContacts.getContact(_contacts![i].id);
                  // ignore: use_build_context_synchronously
                  await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
                }),
          ),
        ));
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  const ContactPage(this.contact, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          backgroundColor: Style.primaryColor,
          title: Text(contact.displayName)),
      backgroundColor: Style.primaryColor,
      body: Column(children: [
        Text('Ism: ${contact.name.first}',style: Style.primaryText(size: 16,textColor: Style.whiteColor),),

        Text(
            'Telefon Raqam: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(mavjud emas)'}',style: Style.primaryText(size: 16,textColor: Style.whiteColor),),
        Text(
            'Elektron pochta: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(mavjud emas)'}',style: Style.primaryText(size: 16,textColor: Style.whiteColor),),
      ]),
  floatingActionButton: FloatingActionButton(
      onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const TransactionPage()));
      } ,
  ),
  );
}