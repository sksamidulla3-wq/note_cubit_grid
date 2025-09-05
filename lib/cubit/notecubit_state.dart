part of 'notecubit_cubit.dart';

@immutable
abstract class NotecubitState {}

final class NotecubitInitialState extends NotecubitState {}

final class NotecubitLoadingState extends NotecubitState {}

final class NotecubitLoadedState extends NotecubitState {
  List<NoteModel> mData;

  NotecubitLoadedState({required this.mData});
}

final class NotecubitErrorState extends NotecubitState {
  String errorMsg;

  NotecubitErrorState({required this.errorMsg});
}
