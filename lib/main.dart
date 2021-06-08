import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
//
// //Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    //
    // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );`
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
      builder: EasyLoading.init(),
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

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
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
                image: NetworkImage('https://www.smartbusinessfunder.com/wp-content/uploads/2021/02/cropped-cropped-smart_business_newest_black.png'),
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
                    hintText: "Client's ID/Track ID"
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: showNotification,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),

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
  showCircularProgressBar(){
      print("Progress1");
      return CircularProgressIndicator();
    }
  _makeGetRequest(String to, String subject, String body, String alertMessage) async {
    EasyLoading.show(status: 'loading...');
    showCircularProgressBar();
    // make request
    final response = await get(Uri.parse('https://multipurpose.skoder.co/api/send-mail/renewals@smartbusinessfunder.com/${subject}/${to} \n ${body}'));

    // sample info available in response
    final statusCode = response.statusCode;
    final headers = response.headers;
    final contentType = headers['content-type'];
    final json = response.body;

    print(statusCode);
    print(headers);
    print(json);

    // TODO convert json to object...
    //End progressbar Here
    EasyLoading.dismiss();
    showAlertDialog(context, subject, alertMessage);


  }



}
