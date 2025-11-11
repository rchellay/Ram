import 'package:cloud_functions/cloud_functions.dart';

class StripeService {
  final FirebaseFunctions _functions;

  StripeService({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  Future<String> createStripeAccount() async {
    final callable = _functions.httpsCallable('createStripeAccount');
    final response = await callable.call();
    return response.data['url'];
  }

  Future<String> createStripeCheckout() async {
    final callable = _functions.httpsCallable('createStripeCheckout');
    final response = await callable.call();
    return response.data['url'];
  }
}
