@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Customer Orders'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_CS04_ORDERS
  as projection on ZR_CS04_Orders
  association [1..1] to ZR_CS04_Orders as _BaseEntity on $projection.Customerid = _BaseEntity.Customerid and $projection.Orderid = _BaseEntity.Orderid
{
  @EndUserText: {
    label: 'Kundennummer', 
    quickInfo: 'CustomerID'
  }
  key Customerid,
  @EndUserText: {
    label: 'Bestellnummer', 
    quickInfo: 'Bestellnummer'
  }
  key Orderid,
  @EndUserText: {
    label: 'Datum der Bestellung', 
    quickInfo: 'Datum der Bestellung'
  }
  OrderDate,
  @EndUserText: {
    label: 'Summe der Bestellung', 
    quickInfo: 'Summe der Bestellung'
  }
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  OrderTotal,
  @EndUserText: {
    label: 'Rabat', 
    quickInfo: 'Rabat'
  }
  Discount,
  @EndUserText: {
    label: 'Info', 
    quickInfo: 'Info'
  }
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
  @EndUserText: {
    label: 'Währung', 
    quickInfo: 'Währung'
  }
  Currency,
  @EndUserText: {
    label: 'Created By', 
    quickInfo: 'Created By User'
  }
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @EndUserText: {
    label: 'Created On', 
    quickInfo: 'Creation Date Time'
  }
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @EndUserText: {
    label: 'Changed By', 
    quickInfo: 'Local Instance Last Changed By User'
  }
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @EndUserText: {
    label: 'Changed On', 
    quickInfo: 'Local Instance Last Change Date Time'
  }
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @EndUserText: {
    label: 'Changed On', 
    quickInfo: 'Last Change Date Time'
  }
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _Customer : redirected to parent ZC_CS04_CUSTOMER,
  _BaseEntity
}
