import 'dart:async';

import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/repository/cart_repository/cart_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  User? _loggedFirebaseUser;
  StreamSubscription? _cartSubscription;

  CartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(CartLoading());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield* _mapLoadCartToState(event);
    } else if (event is AddCartItem) {
      yield* _mapAddCartItemToState(event);
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemToState(event);
    } else if (event is UpdateCartItem) {
      yield* _mapUpdateCartItemToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
    } else if (event is CartUpdated) {
      yield* _mapCartUpdatedToState(event);
    }
  }

  Stream<CartState> _mapLoadCartToState(LoadCart event) async* {
    try {
      _loggedFirebaseUser = event.loggedFirebaseUser;
      _cartSubscription?.cancel();
      _cartSubscription =
          _cartRepository.cartStream(_loggedFirebaseUser!.uid)!.listen(
                (cart) => add(CartUpdated(cart)),
              );
    } catch (e) {
      yield CartLoadFailure(e.toString());
    }
  }

  Stream<CartState> _mapAddCartItemToState(AddCartItem event) async* {
    try {
      await _cartRepository.addCartItem(
          _loggedFirebaseUser!.uid, event.cartItem);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapRemoveCartItemToState(RemoveCartItem event) async* {
    try {
      await _cartRepository.removeCartItem(_loggedFirebaseUser!.uid, event.pid);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapUpdateCartItemToState(UpdateCartItem event) async* {
    try {
      await _cartRepository.updateCartItem(
          _loggedFirebaseUser!.uid, event.cartItem);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapClearCartToState() async* {
    try {
      await _cartRepository.clearCart(_loggedFirebaseUser!.uid);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapCartUpdatedToState(CartUpdated event) async* {
    var sum = 0;
    event.cart.forEach((c) => sum += c.price);
    yield CartLoaded(event.cart, sum);
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _loggedFirebaseUser = null;
    return super.close();
  }
}
