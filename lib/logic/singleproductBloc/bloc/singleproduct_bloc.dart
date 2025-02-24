import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'singleproduct_event.dart';
import 'singleproduct_state.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final ProductRepository repository;

  String? selectedColor;
  int quantity = 1;

  SingleProductBloc(this.repository) : super(SingleProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(SingleProductLoading());
      try {
        final product = await repository.fetchProduct(event.type, event.id);

        List<String> colors = product.colors;
        selectedColor = colors.isNotEmpty ? colors[0] : null;

        emit(
          SingleProductLoaded(
            product: product,
            availableColors: colors,
            selectedColor: selectedColor,
            quantity: quantity,
          ),
        );
      } catch (e) {
        emit(SingleProductError(e.toString()));
      }
    });

    // Handle color selection event
    on<SelectColor>((event, emit) {
      selectedColor = event.color;
      // Emit updated loaded state with new color
      emit(SingleProductLoaded(
        product: (state as SingleProductLoaded).product,
        availableColors: (state as SingleProductLoaded).availableColors,
        selectedColor: selectedColor,
        quantity: (state as SingleProductLoaded).quantity,
      ));
    });

    // Handle quantity change event
    on<ChangeQuantity>((event, emit) {
      quantity = event.quantity;
      // Emit updated loaded state with new quantity
      emit(SingleProductLoaded(
        product: (state as SingleProductLoaded).product,
        availableColors: (state as SingleProductLoaded).availableColors,
        selectedColor: (state as SingleProductLoaded).selectedColor,
        quantity: quantity,
      ));
    });
  }
}
