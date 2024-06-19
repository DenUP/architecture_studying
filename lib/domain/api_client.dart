import 'dart:convert';
import 'dart:io';

class ApiClient {
  final client = HttpClient();

  void getPost() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final requset = await client.getUrl(url);
    final response = await requset.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString);
    return json;
  }
}
