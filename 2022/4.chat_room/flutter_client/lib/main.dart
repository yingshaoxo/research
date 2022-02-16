import 'package:club_house/models/room.dart';
import 'package:club_house/models/user.dart';
import 'package:club_house/pages/room/my_chat_room_page.dart';
import 'package:club_house/store/global_controller_variables.dart';
import 'package:club_house/util/style.dart';
import 'package:club_house/utils.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(MyApp());
}

const userNumbersInThisRoom = 4;

String getARandomCatPicturePath() {
  return 'assets/images/cat${getARandomNumber(1, userNumbersInThisRoom)}.jpg';
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    () async {
      await myGlobalInitFunction();
    }();

    variableController.cron.schedule(Schedule(seconds: "*/1"), () async {
      // print('every 1 minutes');
      var newUUIDlist = await grpcController.getCurrentUserUUIDlist();

      for (var uuid in newUUIDlist) {
        if (!variableController.currentUsersUUID.contains(uuid)) {
          variableController.currentUsersUUID.add(uuid);
        }
      }

      for (var uuid in variableController.currentUsersUUID) {
        if (!newUUIDlist.contains(uuid)) {
          variableController.currentUsersUUID.remove(uuid);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clubhouse UI Clone',
        theme: ThemeData(
          scaffoldBackgroundColor: Style.LightBrown,
          appBarTheme: AppBarTheme(
            color: Style.LightBrown,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: Obx(() {
          Room myRoom = Room.fromJson({
            'title': "yingshaoxo's chat room",
            "users": variableController.currentUsersUUID
                .map((uuid) => User.fromJson({
                      'name': uuid.substring(0, 8),
                      'profileImage': getARandomCatPicturePath()
                    }))
                .toList(),
            'speakerCount': variableController.currentUsersUUID.length,
          });

          return RoomPage(
            room: myRoom,
          );
        })
        // home: WelcomePage(),
        );
  }
}
