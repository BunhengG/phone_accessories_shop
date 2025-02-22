import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'product_by_category_event.dart';
import 'product_by_category_state.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final ProductRepository productRepository;

  ProductByCategoryBloc(this.productRepository)
      : super(ProductByCategoryLoading()) {
    on<FetchProductsByCategory>(_fetchProductsByCategory);
  }

  Future<void> _fetchProductsByCategory(FetchProductsByCategory event,
      Emitter<ProductByCategoryState> emit) async {
    emit(ProductByCategoryLoading());

    try {
      final products =
          await productRepository.fetchProductsByCategory(event.categoryName);
      emit(ProductByCategoryLoaded(products: products));
    } catch (e) {
      emit(ProductByCategoryError("Failed to load products: $e"));
    }
  }
}
