import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController emailC = new TextEditingController();
  TextEditingController detailsC = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to BeeTechnologyBD',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                ),
                controller: emailC,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Details'
                ),
                controller: detailsC,
              ),

              RaisedButton(
                onPressed: (){
                  setState(() {
                    // sendEmail('Check Statement',emailC.text,detailsC.text);
                    showAlertDialog(context, 'Check Statement', 'Your request to check statement has been placed successfully. We will email you with your query very soon');
                  });
                },
                child: Text('Check Statement'),
              )
            ],
          ),
        ),
      )

    );
  }

  // Future<void> sendEmail(String s, String emailc, String details) async {
  //   final Email email = Email(
  //     body: '$emailc requested to get $s. Account details $details',
  //     subject: '$s',
  //     recipients: ['abir.skoder@gmail.com'],
  //     // attachmentPaths: ['/path/to/attachment.zip'],
  //     isHTML: false,
  //   );
  //
  //   await FlutterEmailSender.send(email);
  //
  // }



  showAlertDialog(BuildContext context, String title, String message) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.pop(context);},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$title"),
      content: Text("$message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}
