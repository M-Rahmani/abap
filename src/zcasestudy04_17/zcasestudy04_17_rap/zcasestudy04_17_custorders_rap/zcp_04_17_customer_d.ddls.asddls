@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Orders'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCP_04_17_Customer_D as projection on ZC_04_17_Customer_D as Orders
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
  Status,
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
   _Customer_M : redirected to parent ZCP_04_17_Customer_M
}
