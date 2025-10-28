import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:equatable/equatable.dart';

abstract class DeliveryAddressEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddNewDeliveryAddress extends DeliveryAddressEvent {
  final Address address;

  AddNewDeliveryAddress(this.address);

  @override
  List<Object?> get props => [address];
}


class AddressId extends DeliveryAddressEvent {
  final int addressid;

  AddressId(this.addressid);

  @override
  List<Object?> get props => [addressid];
}

class UpdateAddress extends DeliveryAddressEvent{
  final Address address;
  UpdateAddress(this.address);
}

class RemoveDeliveryAddress extends DeliveryAddressEvent {
  final int addressId;

  RemoveDeliveryAddress(this.addressId);

  @override
  List<Object?> get props => [addressId];
}


class ClearAddress extends DeliveryAddressEvent {}
