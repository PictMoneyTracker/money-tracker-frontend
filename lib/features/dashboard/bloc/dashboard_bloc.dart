import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  DashboardBloc() : super(DashboardInitialState()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<DashboardInitialEvent>((event, emit) {
      emit(DashboardLoadingState());
      // TODO: implement Firebase call
      Future.delayed(const Duration(seconds: 2));
      emit(DashboardIndexChangedState(_currentIndex));
    });

    on<DashboardIndexChangedEvent>((event, emit) {
      emit(DashboardLoadingState());
      _currentIndex = event.index;
      if (_currentIndex == 0) {
        emit(AllowancePageLoadedState());
      } else if (_currentIndex == 1) {
        emit(StipendPageLoadedState());
      } else if (_currentIndex == 2) {
        emit(StocksPageLoadedState());
      } else {
        emit(
          DashboardErrorState('Index out of bounds'),
        );
      }
    });
  }
}
