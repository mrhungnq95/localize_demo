import 'package:json_annotation/json_annotation.dart';
import 'package:localize_demo/model/customer.dart';
import 'package:localize_demo/model/inventory_item.dart';

part 'revenue_data.g.dart';

@JsonSerializable()
class RevenueData {
  List<InventoryItem> inventoryItemList;

  List<Customer> customerList;

  RevenueData(this.inventoryItemList, this.customerList);

  factory RevenueData.fromJson(Map<String, dynamic> json) =>
      _$RevenueDataFromJson(json);
}
