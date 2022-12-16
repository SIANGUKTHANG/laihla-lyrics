import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Services {

  //post to database
  postToDatabase(url,api,title,composer,singer,v1,v2,v3,v4,v5,cho,ending,)async{
    try {
      final response = await http.post(Uri.parse(url),
         headers: {
            "Authorization": "Bearer $api",

           "Content-Type": "application/json",
          },

        body: jsonEncode({
          "records": [
            {
              "fields": {
                "title": title,
                "composer": composer,
                "singer": singer,
                "verse 1": v1,
                "verse 2": v2,
                "verse 3": v3,
                "verse 4": v4,
                "verse 5": v5,
                "chorus": cho,
                "ending chorus": ending,
              }
            },

          ],
        }),
      );

      // TODO: Whatever you want to do with the response. A good practice is to transform it into models and than work with them
      }catch(e){
debugPrint(e.toString());
    };
    }


  Future getPathianHla()async{

    final data = await http.get(Uri.parse('https://www.googleapis.com/blogger/v3/blogs/5073631544268148441/posts?key=AIzaSyCGdOvHoAObraem6-9rv_EfO9Dgj2zundI'));
    var body = jsonDecode(data.body);
    return body['items'];
  }
  Future searchPathianHla(String name)async{

    final data = await http.get(Uri.parse('https://blogger.googleapis.com/v3/blogs/5073631544268148441/posts/search?q=$name&fetchBodies=true&key=AIzaSyCGdOvHoAObraem6-9rv_EfO9Dgj2zundI'));
    var body = jsonDecode(data.body);
    return body['items'];
  }

  Future getLoveSongHla()async{

    final data = await http.get(Uri.parse('https://www.googleapis.com/blogger/v3/blogs/6048966854851688031/posts?key=AIzaSyCGdOvHoAObraem6-9rv_EfO9Dgj2zundI'));
    var body = jsonDecode(data.body);
    return body['items'];
  }


  fetchPathianhla1 ()async {
    String url = "https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%201?maxRecords=500&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
     return result['records'];

  }
  fetchPathianhla2 ()async {
    String url = "https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%202?maxRecords=500&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchPathianhla3 ()async {
    String url = "https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%203?maxRecords=500&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchPathianhla4 ()async {
    String url = "https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%204?maxRecords=500&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchPathianhla5 ()async {
    String url = "https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%205?maxRecords=500&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchPathianhla6 ()async {
    String url = "https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%206?maxRecords=500&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchZunhla1 ()async {
    String url = "https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%201?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchZunhla2 ()async {
    String url = "https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%202?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchZunhla3 ()async {
    String url = "https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%203?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchZunhla4 ()async {
    String url = "https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%204?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchZunhla5 ()async {
    String url = "https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%205?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchZunhla6 ()async {
    String url = "https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%206?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }

  //khrihfa hlabu
  fetchKhrifaHlaBu1 ()async {
    String url = "https://api.airtable.com/v0/appTOJYkWuyVFCstZ/Table%201?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);

    return result['records'];

  }
  fetchKhrifaHlaBu2 ()async {
    String url = "https://api.airtable.com/v0/appTOJYkWuyVFCstZ/Table%202?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);

    return result['records'];

  }
  fetchKhrifaHlaBu3 ()async {
    String url = "https://api.airtable.com/v0/appTOJYkWuyVFCstZ/Table%203?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);

    return result['records'];

  }
  fetchKhrifaHlaBu4 ()async {
    String url = "https://api.airtable.com/v0/appTOJYkWuyVFCstZ/Table%204?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);

    return result['records'];

  }
  fetchKhrifaHlaBu5 ()async {
    String url = "https://api.airtable.com/v0/appTOJYkWuyVFCstZ/Table%205?maxRecords=100&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);

    return result['records'];

  }
  fetchKhrifaHlaBu6 ()async {
    String url = "https://api.airtable.com/v0/appTOJYkWuyVFCstZ/Table%206?maxRecords=50&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);

    return result['records'];

  }

  //chawnghlang
  checkLine ()async {
    String url = "https://api.airtable.com/v0/app569VQbPNzeVg26/Table%202?maxRecords=52&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }
  fetchChawnghlang ()async {
    String url = "https://api.airtable.com/v0/app569VQbPNzeVg26/Table%201?maxRecords=52&view=Grid%20view";
    Map<String, String> headers = {"Authorization": "Bearer key5sIyVikcL1LG8S"};
    http.Response res =  await http.get(Uri.parse(url),headers: headers);
    Map<String,dynamic> result = json.decode(res.body);
    return result['records'];

  }

  //download audio

  Future<File?> downloadFiles(String url,String dir,) async {

    var httpClient = http.Client();
    var request =   http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);


    List<List<int>> chunks = [];
    int downloaded = 0;

    final file = await _getFile(dir);

    response.asStream().listen((http.StreamedResponse r) {


      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        //  debugPrint('downloadPercentage: ${downloaded / r.contentLength! * 100}');
    //    progress = (downloaded/r.contentLength!*100).floorToDouble()/200;

        chunks.add(chunk);
        downloaded += chunk.length;


      }, onDone: () async {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength! * 100}');
        //   progress = (downloaded/r.contentLength!*100).floorToDouble();
      //  progress = 1;

        // Save the file

        Uint8List bytes = Uint8List(r.contentLength!);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }

        await file.writeAsBytes(bytes);

        return;
      });
    });
    return file;
  }

  Future<File> _getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    // final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$filename");
  }



}