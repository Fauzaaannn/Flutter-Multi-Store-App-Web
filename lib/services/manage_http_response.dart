import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response, // the http response from the request
  required BuildContext context, // the context is to show snackbars
  required VoidCallback
      onSuccess, // the callback to execute on a successful response
}) {
  // switch statements to handle different http status codes
  switch (response.statusCode) {
    case 200: // if the response is successful
      onSuccess(); // execute the onSuccess callback
      break;
    case 400: // if the response is a bad request
      showSnackBar(context, json.decode(response.body)['message']);
      break;
    case 500: // if the response is a server error
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 201: // if the response is a created
      onSuccess(); // execute the onSuccess callback
      break;
    default: // if the response is any other status code
      showSnackBar(context, 'Something went wrong');
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(title),
  ));
}
