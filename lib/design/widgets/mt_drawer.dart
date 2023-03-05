import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/features/dashboard/ui/mt_dashboard.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../pages/settings_page.dart';

class MtDrawer extends StatelessWidget {
  const MtDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 250,
            width: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  "John Doe",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abc@gmail.com"),
                currentAccountPictureSize: Size.square(70),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 25.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              // trailing: Icon(Icons.more_vert),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MtDashboard(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
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
          Card(
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
              // trailing: Icon(Icons.more_vert),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              // trailing: Icon(Icons.more_vert),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
          ),
          Expanded(child: Container()),
          Container(
              padding: const EdgeInsets.all(8.5),
              child: const Text("Made with ❤️ by Atharv & Purva"))
        ],
      ),
    );
  }
}
