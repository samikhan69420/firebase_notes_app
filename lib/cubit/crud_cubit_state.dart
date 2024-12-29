part of 'crud_cubit_cubit.dart';

sealed class CrudCubitState extends Equatable {
  const CrudCubitState();
}

final class CrudCubitInitial extends CrudCubitState {
  @override
  List<Object> get props => [];
}

final class CrudCubitLoading extends CrudCubitState {
  @override
  List<Object> get props => [];
}

final class CrudCubitLoaded extends CrudCubitState {
  final List<NoteModel> notes;

  const CrudCubitLoaded(this.notes);
  @override
  List<Object> get props => [notes];
}

final class CrudCubitError extends CrudCubitState {
  @override
  List<Object> get props => [];
}
