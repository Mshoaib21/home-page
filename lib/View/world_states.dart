import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:http/http.dart'as https;
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';

class WorldsStatesScreen extends StatefulWidget {
  const WorldsStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldsStatesScreen> createState() => _WorldsStatesScreenState();
}

class _WorldsStatesScreenState extends State<WorldsStatesScreen> with TickerProviderStateMixin{
  late final AnimationController _controller= AnimationController(
      duration: Duration(seconds: 4),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorList=<Color>[
   const Color(0xff4285fe),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return  Scaffold(
      appBar: AppBar(
        title: Text("Virus Record"),
        
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),

              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){

                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                      );

                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: const {
                              "Total":50,
                              "Recovered":20,
                              "Death":20,
                            },
                            chartRadius: MediaQuery.of(context).size.width /3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1),
                            child: Card(
                                color: Colors.orangeAccent,
                                child:Column(
                                  children: [
                                    ReusableRow(title: 'Total', value: '200'),
                                    ReusableRow(title: 'Recovered', value: '20'),
                                    ReusableRow(title: 'Death', value: '290'),
                                  ],
                                )

                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:const Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        ],
                      );

                    }

                  }),
            ],
          ),
        ),

      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
  }
}

