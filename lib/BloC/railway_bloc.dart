import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository/API/Railway/Railway_Api.dart';
import '../Repository/Model_class/RailwayModel.dart';

part 'railway_event.dart';

part 'railway_state.dart';

class RailwayBloc extends Bloc<RailwayEvent, RailwayState> {
  RailwayApi railwayApi = RailwayApi();
  late RailwayModel railwayModel;

  RailwayBloc() : super(RailwayInitial()) {
    on<FetchRailway>((event, emit) async {
      emit(RailwayBlocLoading());
      try {
        railwayModel = await railwayApi.getRailway(location: event.location);
        emit(RailwayBlocLoaded());
      } catch (e) {
        print(e);
        emit(RailwayBlocError());
      }
    });
  }
}
