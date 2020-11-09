// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevenueData _$RevenueDataFromJson(Map<String, dynamic> json) {
  return RevenueData(
    (json['inventoryItemList'] as List)
        ?.map((e) => e == null
            ? null
            : InventoryItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['customerList'] as List)
        ?.map((e) =>
            e == null ? null : Customer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RevenueDataToJson(RevenueData instance) =>
    <String, dynamic>{
      'inventoryItemList': instance.inventoryItemList,
      'customerList': instance.customerList,
    };
