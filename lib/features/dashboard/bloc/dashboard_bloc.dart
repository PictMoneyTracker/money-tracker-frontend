import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/api_service/firebase_crud_service/user_service/models/user_model.dart';
import '../../../core/api_service/firebase_crud_service/user_service/user_service.dart';
import '../../../core/api_service/firebase_crud_service/stock_service/models/stock_model.dart';
import '../../../core/api_service/firebase_crud_service/stock_service/stock_service.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/transaction_service.dart';
import '../../../core/api_service/firebase_crud_service/utils/categories.dart';
import '../../../main.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  DashboardBloc() : super(DashboardInitialState()) {
    final id = sharedPref.getString('id');
    late UserModel userModel;
    on<DashboardInitialEvent>((event, emit) async {
      emit(DashboardLoadingState());
      final userModelResponse = await UserApiService.readDoc(id!);

      userModel = userModelResponse.getData!;
      emit(DashboardIndexChangedState(_currentIndex));
    });

    on<DashboardIndexChangedEvent>((event, emit) async {
      emit(DashboardLoadingState());
      final userModelResponse = await UserApiService.readDoc(id!);
      if (userModelResponse.hasData) {
        userModel = userModelResponse.getData!;
      } else if (userModelResponse.hasException) {
        emit(DashboardErrorState(userModelResponse.getException!));
      }

      _currentIndex = event.index;
      if (_currentIndex == 0) {
        final stockBalance = userModel.stockTotal;
        final stocks = <StockModel>[];
        final response = await StockApiService.readCollection(id);
        if (response.hasData) {
          stocks.addAll(response.getData!);
        } else if (response.hasException) {
          emit(DashboardErrorState(response.getException!));
        }
        emit(StocksPageLoadedState(stocks, stockBalance));
      } else if (_currentIndex == 1) {
        final stipendBalance = userModel.stipendTotal;

        int stipendSpent = 0;
        final transactions = <TransactionModel>[];
        final response = await TransactionApiService.readCollection(
            id, SpendFrom.stipend);

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
        final allowanceBalance = userModel.allowanceTotal;

        int allowanceSpent = 0;
        final transactions = <TransactionModel>[];
        final response = await TransactionApiService.readCollection(
            id, SpendFrom.allowance);

        if (response.hasData) {
          transactions.addAll(response.getData!);
          for (var element in transactions) {
            allowanceSpent += element.amount;
          }
        } else if (response.hasException) {
          emit(DashboardErrorState(response.getException!));
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
