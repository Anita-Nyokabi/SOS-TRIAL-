import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:crime_reporting_app/api_service.dart';
import 'package:crime_reporting_app/recommendation_screen.dart';

class ReportCrimeScreen extends StatefulWidget {
  @override
  _ReportCrimeScreenState createState() => _ReportCrimeScreenState();
}

class _ReportCrimeScreenState extends State<ReportCrimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reportModel = ReportModel();

  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Crime'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _reportModel.description = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) => _reportModel.location = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _getCurrentLocation();
                    await ApiService.submitReport(_reportModel, _currentPosition);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Report submitted successfully')),
                    );
                  }
                },
                child: Text('Submit Report'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recommendation');
                },
                child: Text('Get Mental Health Recommendations'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }
}
