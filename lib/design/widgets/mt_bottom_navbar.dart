import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/dashboard/bloc/dashboard_bloc.dart';

class MtBottomNavbar extends StatelessWidget {
  const MtBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 25,
      selectedFontSize: 16,
      unselectedFontSize: 13,
      selectedItemColor: const Color.fromRGBO(10, 173, 18, 0.698),
      currentIndex: context.select((DashboardBloc bloc) => bloc.currentIndex),
      onTap: (index) {
        BlocProvider.of<DashboardBloc>(context)
            .add(DashboardIndexChangedEvent(index));
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, color: Colors.lightGreen),
          label: 'Stocks',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.paid,
            color: Colors.lightGreen,
          ),
          label: 'Stipend',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet,
            color: Colors.lightGreen,
          ),
          label: 'Allowance',
        ),
      ],
    );
  }
}
