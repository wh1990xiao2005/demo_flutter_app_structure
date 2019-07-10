import 'dart:convert';

class JsonParser {

  JsonParser(this.jsonStr);

  final String jsonStr;

  Object parseFromJson(){
    return json.decode(jsonStr);
  }

}