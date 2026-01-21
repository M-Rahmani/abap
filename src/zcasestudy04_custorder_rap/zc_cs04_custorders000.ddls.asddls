@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS04_CUSTORDERS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS04_CUSTORDERS000
  provider contract transactional_query
  as projection on ZR_CS04_CUSTORDERS
  association [1..1] to ZR_CS04_CUSTORDERS as _BaseEntity on $projection.Customerid = _BaseEntity.Customerid and $projection.Orderid = _BaseEntity.Orderid
{
  key Customerid,
  key Orderid,
  OrderDate,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  OrderTotal,
  Discount,
  Info,
  @UI.textArrangement: #TEXT_ONLY 
  @ObjectModel.text.element: [ 'StatusText' ]          
  Status,
  _StatusText.text as StatusText,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
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
  _StatusText
}
