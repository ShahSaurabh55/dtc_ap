import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  var text = 'Test SOAP request to a .NET Webservice (WSDL) with Flutter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              String requestBody = '''<?xml version="1.0"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:j55="http://j550700.bssv.e1.oracle/">
  <soapenv:Header/>
  <soapenv:Body>
    <j55:updatephonenumber>      
        <j55:additionalemployeeno>2191997</j55:additionalemployeeno>    
        <j55:addressline1>971559247531</j55:addressline1>
    </j55:updatephonenumber>
  </soapenv:Body>
</soapenv:Envelope>''';

              var request =
                  'http://192.168.24.32:7868/PD920/ServiceManagerWebTesterService?WSDL';

              http.Response response = await http.post(request,
                  headers: {
                    "SOAPAction":
                        "http://192.168.24.32:7868/PD920/ServiceManagerWebTesterService",
                    "Content-Type": "text/xml;charset=UTF-8",
                  },
                  body: convert.utf8.encode(requestBody));

              if (response.statusCode == 200) {
                setState(() {
                  text = 'Request Successful';
                });
              } else {
                text = 'Request Failed';
              }
            },
            child: Text(text)),
      ),
    );
  }
}
