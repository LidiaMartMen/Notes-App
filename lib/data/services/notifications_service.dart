
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class NotificationService {
// CREAR INSTANCIA DEL OBJETO QUE MANDA LAS NOTIFICACIONES:
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

// INICIALIZAR LAS CONFIGURACIONES DE NOTIFICACIÓN:
  Future<void> initLocalNotifications() async {
    // ANDROID SETTINGS:
    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('icon_flutter');

    // Combinar las configuraciones de los distintos dispositivos: en nuestro caso sólo Android.
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initSettingsAndroid);

    // Iniciar plugin notificaciones con las configuraciones:
    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        
      },
    );
  }


  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            priority: Priority.high));
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    
    return notificationPlugin.show(0, title, body,await notificationDetails(),); //Payload: añadir información relevante para el usuario.
  }
}
