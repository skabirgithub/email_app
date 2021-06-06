import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Service Request'),
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
              Image(
                image: NetworkImage('https://www.beetechnologybd.com/assets/front/img/6071d5904cd84.png'),
              ),
              SizedBox(height: 20,),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: (){
                      setState(() {
                        _makeGetRequest(emailC.text,'Check Balance', detailsC.text, 'Your request to check balance has been placed successfully. We will email you with your query very soon');
                      });
                    },
                    child: Text('Balance'),
                  ),
                  RaisedButton(
                    onPressed: (){
                      setState(() {
                        _makeGetRequest(emailC.text,'Check Statement', detailsC.text, 'Your request to check balance has been placed successfully. We will email you with your query very soon');
                      });
                    },
                    child: Text('Statement'),
                  ),
                  RaisedButton(
                    onPressed: (){
                      setState(() {
                        _makeGetRequest(emailC.text,'Renew Account', detailsC.text, 'Your request to Renew Account has been placed successfully. We will email you with your query very soon');
                      });
                    },
                    child: Text('Renew Account'),
                  ),
                ],
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

  _makeGetRequest(String to, String subject, String body, String alertMessage) async {

    // make request
    final response = await get(Uri.parse('https://multipurpose.skoder.co/api/send-mail/${to}/${subject}/${body}'));

    // sample info available in response
    final statusCode = response.statusCode;
    final headers = response.headers;
    final contentType = headers['content-type'];
    final json = response.body;

    print(statusCode);
    print(headers);
    print(json);

    // TODO convert json to object...
    showAlertDialog(context, subject, alertMessage);


  }



}
