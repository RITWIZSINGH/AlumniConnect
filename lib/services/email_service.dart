import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  static const String baseUrl = 'http://localhost:3001';

  static Future<void> sendReferralRequest({
    required String userEmail,
    required String alumniEmail,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sendmail'),
        headers: {
          'Content-Type': 'application/json',
          // Add any additional headers if needed
        },
        body: json.encode({
          'userMail': userEmail,
          'alumniMail': alumniEmail,
        }),
      );

      if (response.statusCode != 200) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['error'] ?? 'Failed to send referral request');
      }
    } catch (e) {
      throw Exception('Failed to send referral request: ${e.toString()}');
    }
  }
}