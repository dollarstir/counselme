import 'package:awesome_notifications/awesome_notifications.dart';
import './utils/utility.dart';


Future<void> creatNotification($message,$pic) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: generateuid(),
    channelKey: 'basic_channel',
    title :'Counsel-Me',
    body: $message,
    bigPicture: 'https://icounselgh.net/main/default/upload/'+$pic,
    notificationLayout: NotificationLayout.BigPicture,
  ));
}

Future<void> creatNotificationupdate() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: generateuid(),
    channelKey: 'basic_channel',
    title :'Counsel-Me',
    body: 'Update Available. Visit playstore to update',
    bigPicture: 'asset://assets/images/logo.jpg',
    notificationLayout: NotificationLayout.BigPicture,
    
  ));
}


Future<void> creatNotificationnopic($message) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: generateuid(),
    channelKey: 'basic_channel',
    title :'Counsel-Me',
    body: $message,
    // bigPicture: 'https://www.tict-edu.org/images/tucee/5.png',
    notificationLayout: NotificationLayout.Inbox,
  ));
}
