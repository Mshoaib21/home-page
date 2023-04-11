import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;

import '../Model/WorldStatesModel.dart';
//import '../Model/world_states_model.dart';

class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecords()async{

    final response= await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode==200){

      var data=jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('error');

    }

  }
}
