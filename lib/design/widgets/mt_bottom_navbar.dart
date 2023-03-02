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
      currentIndex: context.select((DashboardBloc bloc) => bloc.currentIndex),
      onTap: (index) {
        BlocProvider.of<DashboardBloc>(context)
            .add(DashboardIndexChangedEvent(index));
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Stocks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.paid),
          label: 'Stipend',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Allowance',
        ),
      ],
    );
  }
}
