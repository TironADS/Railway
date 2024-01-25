part of 'railway_bloc.dart';

@immutable
abstract class RailwayEvent {}

class FetchRailway extends RailwayEvent {
  final String location;

  FetchRailway({required this.location});
}