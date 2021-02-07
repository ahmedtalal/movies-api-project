import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testing/Models/Movies.dart';

class HttpBuilder {
  static HttpBuilder _builder ;

  // is used to create only one instance form this class >>>>>
  static HttpBuilder getInstance(){
    if(_builder == null){
      return _builder = HttpBuilder() ;
    }
    return _builder ;
  }

  // send a request to server then return the response by http.get() method >>>
  Future<http.Response> _getHttpResponse(String url) {
    return  http.get(url);
  }

  Future<List<Movies>> getMovies(String url) async{
    final response  = await _getHttpResponse(url) ;
    if(response.statusCode == 200){
      /**
       * the data is returned in String , this string is json body so you need to convert
       * String to json using json.decode() -> this method take a string then return json
       * and in the end convert json to model
       **/
      List<dynamic> body = json.decode(response.body) ;
      List<Movies> movies = body.map((json) => Movies.fromJson(json)).toList();
      print("movies ${movies.length}");
      return movies ;
    }else {
      // return exception if the result is null >>>>
      print("the error is error");
      return throw Exception("can not load posts from this url") ;
    }
  }
}