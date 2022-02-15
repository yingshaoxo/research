import 'package:club_house/models/room.dart';
import 'package:club_house/models/user.dart';
import 'package:club_house/pages/room/my_chat_room_page.dart';
import 'package:club_house/store/global_controller_variables.dart';
import 'package:club_house/util/style.dart';
import 'package:club_house/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const userNumbersInThisRoom = 4;

String getARandomCatPicturePath() {
  return 'assets/images/cat_${getARandomNumber(0, userNumbersInThisRoom)}.png';
}

// User
List names = [
  'American Bobtail',
  'British Shorthair',
  'Cornish Rex',
  'yingshaoxo',
];

List userData = List.generate(
  userNumbersInThisRoom,
  (index) => {
    'name': names[index],
    'username': '@${names[index].toString().split(' ')[0].toLowerCase()}',
    'profileImage': getARandomCatPicturePath(),
  },
);

Room myRoom = Room.fromJson({
  'title': "yingshaoxo's chat room",
  "users": List.generate(
      userNumbersInThisRoom, (index) => User.fromJson(userData[index]))
    ..shuffle(),
  'speakerCount': userNumbersInThisRoom,
});

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
        home: RoomPage(
          room: myRoom,
        )
        // home: WelcomePage(),
        );
  }
}
