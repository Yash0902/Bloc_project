import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:equatable/equatable.dart';

class DeliveryAddressState extends Equatable{
  final List<Address> addressList;
  const DeliveryAddressState({this.addressList=const []});

  DeliveryAddressState copyWith({
    List<Address>? addressList,
  }) {
    return DeliveryAddressState(
      addressList: addressList ?? this.addressList,
    );
  }


  @override
  List<Object?> get props => [addressList];
}

class UpdateRouteState extends DeliveryAddressState{
      final bool edit;
      UpdateRouteState({required this.edit});
}