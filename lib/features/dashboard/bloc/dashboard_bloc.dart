import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/api_service/firebase_crud_service/stock_service/stock_service.dart';
import '../../../core/api_service/firebase_crud_service/stock_service/models/stock_model.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  DashboardBloc() : super(DashboardInitialState()) {
    User? user = FirebaseAuth.instance.currentUser;

    on<DashboardInitialEvent>((event, emit) {
      emit(DashboardLoadingState());
      emit(DashboardIndexChangedState(_currentIndex));
    });

    on<DashboardIndexChangedEvent>((event, emit) async {
      emit(DashboardLoadingState());
      _currentIndex = event.index;
      if (_currentIndex == 0) {
        final stocks = <StockModel>[];
        final response = await StockApiService.readCollection(user!.uid);
        if (response.hasData) {
          stocks.addAll(response.getData!);
        } else if (response.hasException) {
          emit(DashboardErrorState(response.getException!));
        }
        emit(StocksPageLoadedState(stocks));
      } else if (_currentIndex == 1) {
        emit(StipendPageLoadedState());
      } else if (_currentIndex == 2) {
        emit(AllowancePageLoadedState());
      } else {
        emit(
          DashboardErrorState('Index out of bounds'),
        );
      }
    });
  }
}
