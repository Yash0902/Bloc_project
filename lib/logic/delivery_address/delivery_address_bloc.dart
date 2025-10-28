
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_event.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_state.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressBloc extends Bloc<DeliveryAddressEvent,DeliveryAddressState>{
  DeliveryAddressBloc():super(DeliveryAddressState()){
    on<AddNewDeliveryAddress>(_addNewDeliveryAddress);
    on<RemoveDeliveryAddress>(_removeDeliveryAddress);
    on<AddressId>(_updateDeliveryAddress);

    on<UpdateAddress>(_UpdateAddress);

  }

  void _addNewDeliveryAddress(AddNewDeliveryAddress event, Emitter<DeliveryAddressState> emit){
    List<Address> updateAddressList = List.from(state.addressList);
    updateAddressList.add(event.address);
    emit(DeliveryAddressState(addressList: updateAddressList));
    NavigationService.navigatorKey.currentState!.pushNamed(AppRoutes.deliveryAddress);
  }

  void _removeDeliveryAddress( RemoveDeliveryAddress event,Emitter<DeliveryAddressState> emit){
    final updatedAddress = state.addressList.where((item) => item.id!= event.addressId).toList();
    emit(DeliveryAddressState(addressList: updatedAddress));
  }

  void _updateDeliveryAddress(AddressId event,Emitter<DeliveryAddressState> emit){
    final existingIndex = state.addressList.indexWhere((item) => item.id == event.addressid);
    List<Address> currentAddressList = List.from(state.addressList);
    final Address address = currentAddressList[existingIndex];
    NavigationService.navigatorKey.currentState!.pushNamed(AppRoutes.addAddress,arguments:address);
  }

  void _UpdateAddress(UpdateAddress event,Emitter<DeliveryAddressState>emit){
    final existingIndex = state.addressList.indexWhere((item) => item.id == event.address.id);
    final updatedList = List<Address>.from(state.addressList);
    updatedList[existingIndex] = event.address;
    emit(state.copyWith(addressList: updatedList));
    NavigationService.navigatorKey.currentState!.pop();
  }
}
