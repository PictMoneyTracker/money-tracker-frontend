import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../core/api_service/firebase_crud_service/user_service/user_service.dart';
import '../../../core/api_service/firebase_crud_service/stock_service/models/stock_model.dart';
import '../../../core/api_service/firebase_crud_service/stock_service/stock_service.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/transaction_service.dart';
import '../../../core/api_service/firebase_crud_service/utils/categories.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  DashboardBloc() : super(DashboardInitialState())  {
    User? user = FirebaseAuth.instance.currentUser;

    on<DashboardInitialEvent>((event, emit) {
      emit(DashboardLoadingState());
      emit(DashboardIndexChangedState(_currentIndex));
    });

    on<DashboardIndexChangedEvent>((event, emit) async {
      emit(DashboardLoadingState());
      final userModelResponse = await UserApiService.readDoc(user!.uid);
      
      _currentIndex = event.index;
      if (_currentIndex == 0) {
        final stocks = <StockModel>[];
        final response = await StockApiService.readCollection(user.uid);
        if (response.hasData) {
          stocks.addAll(response.getData!);
        } else if (response.hasException) {
          emit(DashboardErrorState(response.getException!));
        }
        emit(StocksPageLoadedState(stocks));
      } else if (_currentIndex == 1) {
        if (userModelResponse.hasException) {
          emit(DashboardErrorState(userModelResponse.getException!));
        }
        final stipendBalance = userModelResponse.getData!.stipendTotal;

        int stipendSpent = 0;
        final transactions = <TransactionModel>[];
        final response = await TransactionApiService.readCollection(
            user.uid, SpendFrom.stipend);

        if (response.hasData) {
          transactions.addAll(response.getData!);
          for (var element in transactions) {
            stipendSpent += element.amount;
          }
        } else if (response.hasException) {
          emit(DashboardErrorState(response.getException!));
        }
        emit(
          StipendPageLoadedState(
            transactions,
            stipendBalance,
            stipendSpent,
          ),
        );
      } else if (_currentIndex == 2) {
        if (userModelResponse.hasException) {
          emit(DashboardErrorState(userModelResponse.getException!));
        }
        final allowanceBalance = userModelResponse.getData!.allowanceTotal;

        int allowanceSpent = 0;
        final transactions = <TransactionModel>[];
        final response = await TransactionApiService.readCollection(
            user.uid, SpendFrom.allowance);

        if (userModelResponse.hasException) {
          emit(DashboardErrorState(userModelResponse.getException!));
        }
        if (response.hasData) {
          transactions.addAll(response.getData!);
          for (var element in transactions) {
            allowanceSpent += element.amount;
          }
        } else if (response.hasException) {
          emit(DashboardErrorState(response.getException!));
        }
        if (userModelResponse.hasException) {
          emit(DashboardErrorState(userModelResponse.getException!));
        }
        emit(
          AllowancePageLoadedState(
            transactions,
            allowanceBalance,
            allowanceSpent,
          ),
        );
      } else {
        emit(
          DashboardErrorState('Index out of bounds'),
        );
      }
    });
  }
}
