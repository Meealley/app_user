import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:googleapis_auth/auth_io.dart';

Future<String> generateFCMAccessToken() async {
  try {
    /* get these details from the file you downloaded(generated)
          from firebase console
      */
    String type = "service_account";
    String project_id = "kfc-eats";
    String private_key_id = "f494bb87391c91ede0a4732d49307f66320ea8ef";
    String private_key =
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQD6POunqYqg4ndI\nYbKKEIsYUmCbbv826KbhERu1V07bNggaRxfKCcvo1InJcyelFCM1xNs0ThKvJnv7\namk8KwM0ikxrIK/kA+bZ3YqVWeVjuhwvYtbrsRXBmLeJ5LO5586XMbzX7/qzySB+\nZYvRfGwtVbE+0NKK02jg17I84mzfiN/u3DjIknZcYHYUZmCGLZFTWsTlmBuBM6R6\nDQc6Uqs9Vv1b3ZxDr/NvV/03Fo7ODW0lQwijJfrSk4fb3uv4Jo5jrARUqNrlUbFM\nYL7FjY7bU11vP+sSjbPt7hRCk7T80OFpvikYy/0wJZXAd5r91AParawlVwqF2yNq\nk8zACZkBAgMBAAECggEABUJ5i40fOlF4Q1+2UnuViN3WZP34xE0wkMN8yxt6L1Zb\n5j1/TQJWtF6fRMo0V55sPQmVt+w6LU9IRNkQPDEFQLn1cD0AJXFFjWfALXJ1xVpY\nlFBmBw8yT17n4LCbbHloWLo1Z26GXPgJxE5bGXydg3htIM5f1oYqCqvN9cSmmC4s\nLtBuqdlx7XtigvTbfyl5aR2JdskfNMu1OuqFiR2xrHrBasB4xSM0NV88SQ1Y7lTl\nb7xym8yQ5n6FiQv3vP/4Uk6enF9I9o05GWJ0JkaKcOCC3fRiM5dayYAUkvm/Vyju\nuRJrREJtNlIxbdfgT1RnycQQGwSHyGJApsbA9rO7vwKBgQD/vfjAFyDMVOR3QiYx\nm7F97SqTD+aqsL3udIrhXAz8kQIwL7UdDcQquTTobDMG03R/oHlb9UoqG6rfvHfR\nf8bDXmrxvGDCvW9xEbFR2zPP/bpKcej2I7BS25RUHiR4Eumnx3HMldjAoDNyBwOu\nyJggguFKLXxUb/VucFnkSpMIMwKBgQD6fYccdlNR8+mk/sjhUpAKXnxIcp9SiXu/\nAwuucB3zZzXgr0qwKQJ8UMUD08jdnqMBqH3JQNQom4Lm1RCKQufFZMn2QVN2IVg7\n14cXSqze2JbMd9tvORlWIkPOoLRQKm7puGMoQZcQMUam7GkFuSSiuvlJs1h4xeKK\ngblaNBo1+wKBgBReqUWDkhU0Xc4x8qDY6dZB4bY8+f52fWpU1gsFLfOgCTCVXDOo\nOQu+HLy2gYn1pb3UplXwv6uC8KVJebGyH77H8nS2sG5ScGHtKtZ+Qy4543Cyif+w\n8AZpfvMEQ5tcxkea1zGYbd9J408dx+lQCO3t/svNu61uDXpycHaCihuJAoGAecPf\nlBRo+GOrZkt8dxvdbUz0+XrOvB6dCwN+ADP8O0AmzqwnkG6/CJNy0iN3d1QQRVQU\noWpkN8Ew5ukX+z3+0NPn4U9sNPaMn7prrwTb+BAtbgOtpemJyXcqox03yeh2tiKu\nAPmxZ2usvqQZgXC4wGpHmG4YSc1YDKB268R8IVUCgYEA5sfZ2H5xq2+Kx652zZlU\n7dzo7uQ7iYf1DVhKyz1Cb0RCp9UAGo0sQSB6tJj1YY2648L8V8kE6HenbJhTOmuJ\nV9aTGtguvaAMxVlh4+1PB8T+5O//vMjB0MGexQTE6NAfDAY59zv+crrclykSilQ6\nPOsPT5XQADrDYcNgFam3Icc=\n-----END PRIVATE KEY-----\n";
    String client_email =
        "firebase-adminsdk-dbid7@kfc-eats.iam.gserviceaccount.com";
    String client_id = "117668681149494549064";
    String auth_uri = "https://accounts.google.com/o/oauth2/auth";
    String token_uri = "https://oauth2.googleapis.com/token";
    String auth_provider_x509_cert_url =
        "https://www.googleapis.com/oauth2/v1/certs";
    String client_x509_cert_url =
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-dbid7%40kfc-eats.iam.gserviceaccount.com";
    String universe_domain = "googleapis.com";

    final credentials = ServiceAccountCredentials.fromJson({
      "type": type,
      "project_id": project_id,
      "private_key_id": private_key_id,
      "client_email": client_email,
      "private_key": private_key,
      "client_id": client_id,
      "auth_uri": auth_uri,
      "token_uri": token_uri,
      "auth_provider_x509_cert_url": auth_provider_x509_cert_url,
      "client_x509_cert_url": client_x509_cert_url,
      "universe_domain": universe_domain
    });

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    final client = await obtainAccessCredentialsViaServiceAccount(
        credentials, scopes, http.Client());
    final accessToken = client;
    Timer.periodic(const Duration(minutes: 59), (timer) {
      accessToken.refreshToken;
    });
    return accessToken.accessToken.data;
  } catch (e) {
    log("THis is the error: $e");
  }
  return "";
}

Future<void> sendNotificationToTopicAllToSee(
    String title, String description, String topicTOSubscribe) async {
  try {
    String? accessToken = await generateFCMAccessToken();

    var notification = {
      "message": {
        "notification": {
          'title': title,
          'body': description,
        },
        'data': <String, String>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
        },
        "topic": topicTOSubscribe,
      }
    };

    // Send the notification
    var response = await http
        .post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/kfc_eats/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(notification),
    )
        .then((value) {
      log("Successfully sent the push notification");
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      log("Connection timeout");
      throw TimeoutException("Connection timeout");
    }).onError((error, stackTrace) {
      log(error.toString());
      throw Exception(error);
    });

    // else{
    //   print("Token is empty/null");
    // }
  } catch (e) {
    print('Error sending notification: $e');
  }
}
