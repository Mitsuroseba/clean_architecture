import 'package:clean_architecture/di.dart';
import 'package:clean_architecture/presentation/bloc/home_page/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final counterCases = DI.getInstance().counterCase;

  HomePageCubit() : super(HomePageState(count: 0)) {
    emit(HomePageState(count: counterCases.getLastCount()));
  }

  Future<void> incrementCounter() async {
    final _savedValue = await counterCases.saveCount(state.count + 1);
    emit(HomePageState(count: _savedValue));
  }
}
