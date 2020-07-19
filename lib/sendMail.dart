

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';



class sendMail{
  final String email;
  final String name;
  final String subject;
  final String suggestion;
  final String mobile;

  sendMail({this.email,this.name,this.subject,this.suggestion,this.mobile});

  void send()async{
    String username = "feedback.hmentor@gmail.com";
    String password = "Feedback@124";

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(email) //recipent email
      ..ccRecipients.addAll(["hmentor1234567@gmail.com"]) //cc Recipents emails
      //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = subject+' :: 😀 :: ${DateTime.now()}' //subject of the email
      ..text = suggestion; //body of the email

    try {
//      final sendReport = await send(message, smtpServer);
//      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }
  }

