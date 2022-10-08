import 'dart:convert';
import 'package:get/get.dart';

class Constants {
  String url;
  Constants({required this.url});
}

List<Constants> constants = [
  Constants(
    url: 'http://192.168.116.192/v1/livestock-api/public/api/', //0
  ) //
];

// makeMultipartCall(url, body, File imageFile) async {
//   final _fullurl = url;
//   var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//   var length = await imageFile.length();

//   var uri = Uri.parse(_fullurl);

//   var request = http.MultipartRequest("POST", uri);
//   body.forEach((k, v) {
//     request.fields[k] = v;
//   });

//   var multipartFile = http.MultipartFile('file', stream, length,
//       filename: basename(imageFile.path));

//   request.files.add(multipartFile);

//   var response = await request.send();
//   return json.decode(await response.stream.bytesToString());
// }
