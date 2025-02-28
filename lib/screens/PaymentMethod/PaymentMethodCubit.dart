import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodCubit extends Cubit<String> {
  PaymentMethodCubit(super.initialPaymentMethod);

  void selectPaymentMethod(String paymentMethod) {
    emit(paymentMethod);
  }
}
