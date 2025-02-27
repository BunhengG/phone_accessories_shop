import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/logic/cartBloc/bloc/cart_bloc.dart';
import 'package:phone_accessories_shop/logic/singleproductBloc/bloc/singleproduct_bloc.dart';
import 'package:phone_accessories_shop/screens/SplashScreen/splash_screen.dart';
import 'core/api/api_service.dart';
import 'data/models/cart_item_database.dart';
import 'data/repositories/product_repository.dart';
import 'logic/cartBloc/bloc/cart_event.dart';
import 'logic/homeBloc/bloc/home_bloc.dart';
import 'logic/homeBloc/bloc/home_event.dart';
import 'logic/productByCategoryBloc/bloc/product_by_category_bloc.dart';
import 'screens/HomeScreen/home_screen.dart';
import 'screens/NotificationScreen/notification_screen.dart';
import 'screens/PaymentMethod/PaymentMethodCubit.dart';
import 'screens/ProfileScreen/profile_screen.dart';
import 'screens/ReceiptScreen/receipt_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CartItemDatabase.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductRepository(apiService: ApiService()),
      child: MultiBlocProvider(
        providers: [
          // HomeBloc
          BlocProvider(
            create: (context) => HomeBloc(
              ProductRepository(apiService: ApiService()),
            )..add(FetchProducts()),
          ),

          // ProductByCategoryBloc
          BlocProvider(
            create: (context) => ProductByCategoryBloc(
              RepositoryProvider.of<ProductRepository>(context),
            ),
          ),

          // SingleProductBloc
          BlocProvider(
            create: (context) => SingleProductBloc(
              RepositoryProvider.of<ProductRepository>(context),
            ),
          ),

          // CartBloc
          BlocProvider<CartBloc>(
            create: (context) => CartBloc()..add(LoadCartItems()),
          ),

          // PaymentMethodCubit
          BlocProvider<PaymentMethodCubit>(
            create: (context) => PaymentMethodCubit('Cash On Delivery'),
          ),
        ],
        child: MaterialApp(
          title: 'Phone Accessories',
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/notification': (context) => const NotificationScreen(),
            '/receipt': (context) => const ReceiptScreen(),
            '/profile': (context) => const ProfileScreen(),
          },
        ),
      ),
    );
  }
}
