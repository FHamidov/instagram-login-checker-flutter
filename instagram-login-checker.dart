import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> isExists(String user, String password) async {
  final time = DateTime.now().millisecondsSinceEpoch ~/
      1000; // Get current timestamp in seconds
  final url = "https://www.instagram.com/api/v1/web/accounts/login/ajax/";

  // Prepare payload
  final payload = {
    'enc_password': '#PWD_INSTAGRAM_BROWSER:0:$time:$password',
    'optIntoOneTap': 'false',
    'queryParams': {},
    'username': user,
  };

  // Convert payload to URL-encoded string
  final encodedPayload = payload.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
      .join('&');

  // Initial request to get cookies
  final response1 = await http.post(
    Uri.parse(url),
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: encodedPayload, // Use the URL-encoded string
  );

  // Extract cookies
  final cookies = response1.headers['set-cookie'];
  final csrf = _getCookieValue(cookies, 'csrftoken');
  final mid = _getCookieValue(cookies, 'mid');
  final igDId = _getCookieValue(cookies, 'ig_did');
  final igNrcb = _getCookieValue(cookies, 'ig_nrcb');

  // Prepare headers for the second request
  final headers = {
    'X-Csrftoken': csrf,
    'Cookie': 'csrftoken=$csrf; mid=$mid; ig_did=$igDId; ig_nrcb=$igNrcb;',
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  // Second request to authenticate
  final response2 = await http.post(
    Uri.parse(url),
    headers: headers,
    body: encodedPayload, // Use the URL-encoded string
  );

  return json.decode(response2.body);
}

String _getCookieValue(String? cookies, String name) {
  if (cookies != null) {
    final cookieList = cookies.split(';');
    for (var cookie in cookieList) {
      final cookiePair = cookie.split('=');
      if (cookiePair[0].trim() == name) {
        return cookiePair[1].trim();
      }
    }
  }
  return '';
}

void main() async {
  String user = "username"; // Replace with user input as needed
  String password = "password";
  final result = await isExists(user, password);
  if (result["status"] == "ok" &&
      result["authenticated"] != null &&
      result["authenticated"] == true) {
    print("User and password matching");
  } else {
    print("No password or user are correct");
    print(result);
  }
}
