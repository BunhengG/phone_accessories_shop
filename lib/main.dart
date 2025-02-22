import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/screens/HomeScreen/home_screen.dart';
import 'core/api/api_service.dart';
import 'data/repositories/product_repository.dart';
import 'logic/homeBloc/bloc/home_bloc.dart';
import 'logic/homeBloc/bloc/home_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Providing HomeBloc
        BlocProvider(
          create: (context) => HomeBloc(
            ProductRepository(
              apiService: ApiService(),
            ),
          )..add(FetchProducts()),
        ),
      ],
      child: const MaterialApp(
        title: 'Phone Accessories',
        home: HomeScreen(),
      ),
    );
  }
}
