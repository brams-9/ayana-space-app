import 'package:ayana_space_app/cores/dependenciesInjection/dio_di.dart';
import 'package:ayana_space_app/cores/dependenciesInjection/launches_repository_di.dart';
import 'package:ayana_space_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await configureDependencies();
  runApp(const MyApp());
}

Future<void> configureDependencies() async {
  await configureDioDependencies();
  await configureLaunchesRepositoryDependencies();
}
