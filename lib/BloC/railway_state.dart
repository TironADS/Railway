part of 'railway_bloc.dart';

@immutable
abstract class RailwayState {}

class RailwayInitial extends RailwayState {}
class RailwayBlocLoading extends RailwayState {}
class RailwayBlocLoaded extends RailwayState {}
class RailwayBlocError extends RailwayState {}
