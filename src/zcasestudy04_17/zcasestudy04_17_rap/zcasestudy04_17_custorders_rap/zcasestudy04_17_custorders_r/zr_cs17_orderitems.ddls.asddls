@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Items'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZR_CS17_OrderItems as select from zcs04_orderitems as Orderitems
association to parent ZR_CS17_Orders as _Orders on 
 $projection.Orderid = _Orders.Orderid and $projection.Customerid = _Orders.Customerid
association to ZR_CS17_Customer as _Customer on $projection.Customerid = _Customer.Customerid

{  
    key customerid as Customerid,
    key orderid as Orderid,
    key orderitem as Orderitem,
    itemid as Itemid,
    itemdescription as Itemdescription,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    quantity as Quantity,
    unit as Unit,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    item_total as ItemTotal,
    currency as Currency,
    info as Info,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
  _Customer,
  _Orders
}
