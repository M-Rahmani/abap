@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Customer Orders'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_CS17_OrderItems
  as projection on ZR_CS17_OrderItems
  association [1..1] to ZR_CS17_OrderItems as _BaseEntity on $projection.Customerid = _BaseEntity.Customerid and $projection.Orderid = _BaseEntity.Orderid and $projection.Orderitem = _BaseEntity.Orderitem
{
  key Customerid,
  key Orderid,
  key Orderitem,
  Itemid,
  Itemdescription,
  @Semantics: {
    quantity.unitOfMeasure: 'Unit'
  }
  Quantity,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'UnitOfMeasure', 
      entity.name: 'I_UnitOfMeasureStdVH', 
      useForValidation: true
    } ]
  }
  Unit,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  ItemTotal,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  Info,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity,
  _Customer : redirected to ZC_CS17_CUSTOMER,
  _Orders : redirected to parent ZC_CS17_ORDERS
}
