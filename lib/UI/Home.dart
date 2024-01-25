import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway/BloC/railway_bloc.dart';
import 'package:railway/Repository/Model_class/RailwayModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

late RailwayModel data;
TextEditingController controller = TextEditingController();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.train_outlined,
              color: Colors.white,
            ),
            Text(
              '  IRCTC ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  height: 50,
                  width: 370,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 50,
                          width: 260,
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'search location'),
                          )),
                      GestureDetector(
                        onTap: () {
                          print(controller.text);
                          BlocProvider.of<RailwayBloc>(context)
                              .add(FetchRailway(location: controller.text));
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<RailwayBloc, RailwayState>(
                builder: (context, state) {
                  if (state is RailwayBlocLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is RailwayBlocError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.not_listed_location_outlined,
                            color: Colors.red[300],
                            size: 100,
                          ),
                          Text(
                            'Unavailable',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red[300],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is RailwayBlocLoaded) {
                    data = BlocProvider.of<RailwayBloc>(context).railwayModel;
                    return SizedBox(
                      height: 580,
                      child:data.data==null?Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.not_listed_location_outlined,
                            color: Colors.red[300],
                            size: 100,
                          ),
                          Text(
                            'Search station',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red[300],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ): ListView.separated(
                        physics: ScrollPhysics(),
                        itemCount: data.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.train_outlined,
                                    color: Colors.blue[300],
                                    size: 60,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.data![index].code.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      Container(
                                          width: 250,
                                          child: Text(
                                            data.data![index].name.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Row(
                                        children: [
                                          Text(
                                            'State : ',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            data.data![index].stateName
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_searching_rounded,
                            color: Colors.blue[300],
                            size: 100,
                          ),
                          Text(
                            'Search stations',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue[300],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
