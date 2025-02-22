import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;

  HomeBloc(this.productRepository) : super(HomeLoading()) {
    on<FetchProducts>(_loadProducts);
  }

  Future<void> _loadProducts(
      FetchProducts event, Emitter<HomeState> emit) async {
    try {
      final topSellingProducts =
          await productRepository.fetchTopSellingProducts();
      final newInProducts = await productRepository.fetchNewInProducts();
      emit(
        HomeLoaded(
          topSellingProducts: topSellingProducts,
          newInProducts: newInProducts,
        ),
      );
    } catch (e) {
      emit(HomeError("Failed to load data: $e"));
    }
  }
}
