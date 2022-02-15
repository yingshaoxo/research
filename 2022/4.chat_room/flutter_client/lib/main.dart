// import 'package:club_house/pages/lobby/follower_page.dart';
// import 'package:club_house/pages/lobby/lobby_page.dart';
import 'package:club_house/models/room.dart';
import 'package:club_house/models/user.dart';
import 'package:club_house/pages/room/my_chat_room_page.dart';
import 'package:club_house/util/data.dart';
// import 'package:club_house/pages/welcome/welcome_page.dart';
import 'package:club_house/util/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const userNumbersInThisRoom = 4;

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
    'profileImage': 'assets/images/cat${index % userNumbersInThisRoom + 1}.jpg',
  },
);

// Room
List roomData = List.generate(
  userNumbersInThisRoom,
  (index) => {
    'title': "yingshaoxo's chat room",
    "users": List.generate(
        userNumbersInThisRoom, (index) => User.fromJson(userData[index]))
      ..shuffle(),
    'speakerCount': userNumbersInThisRoom,
  },
);

List<Room> rooms = List.generate(
  userNumbersInThisRoom,
  (index) => Room.fromJson(roomData[index]),
);

class MyApp extends StatelessWidget {
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
          room: rooms[0],
        )
        // home: WelcomePage(),
        );
  }
}
