import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/core/api_service/firebase_crud_service/user_service/models/user_model.dart';

import '../../core/api_service/firebase_crud_service/user_service/user_service.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../pages/settings_page.dart';

class MtDrawer extends StatefulWidget {
  const MtDrawer({super.key, required this.id});

  final String id;

  @override
  State<MtDrawer> createState() => _MtDrawerState();
}

class _MtDrawerState extends State<MtDrawer> {
  late UserModel user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserApiService.readDoc(widget.id).then((value) {
      if (value.hasException) {
        print(value.getException!);
      }
      final currentUser = value.getData;
      setState(() {
        user = currentUser!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            width: 250,
            child: DrawerHeader(
              decoration:
                  const BoxDecoration(color: Colors.green), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.green),
                accountName: Text(
                  user.name,
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(user.email),
                // currentAccountPictureSize: const Size.square(70),
                currentAccountPicture: Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(user.photoUrl!),
                    // child: Image.network(user.photoURL!), //Text
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.home, color: Colors.lightGreen),
              title: const Text('Home',
                  style: TextStyle(color: Colors.green, fontSize: 15)),
              // trailing: Icon(Icons.more_vert),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.lightGreen),
              title: const Text('Settings',
                  style: TextStyle(color: Colors.green, fontSize: 15)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ),
          // Card(
          //   child: ListTile(
          //     leading: const Icon(Icons.dark_mode, color: Colors.lightGreen),
          //     title: const Text('Dark Mode',
          //         style: TextStyle(color: Colors.green, fontSize: 15)),
          //     trailing: Switch(
          //       value: true,
          //       onChanged: (value) {
          //         ThemeData.dark();
          //       },
          //     ),
          //     // trailing: Icon(Icons.more_vert),
          //     onTap: () {},
          //   ),
          // ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.lightGreen),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
              },
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.all(8.5),
            child: const Text(
              "Made with ❤️ by Atharv & Purva",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
