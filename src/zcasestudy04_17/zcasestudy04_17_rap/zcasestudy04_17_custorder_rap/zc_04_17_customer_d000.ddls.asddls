@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'Customer Orders'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_04_17_CUSTOMER_D000
  as projection on ZC_04_17_CUSTOMER_D
  association [1..1] to ZC_04_17_CUSTOMER_D as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID and $projection.ORDERID = _BaseEntity.ORDERID
{
  @Endusertext: {
    Label: 'Kundennummer', 
    Quickinfo: 'CustomerID'
  }
  key Customerid,
  @Endusertext: {
    Label: 'Bestellnummer', 
    Quickinfo: 'Bestellnummer'
  }
  key Orderid,
  @Endusertext: {
    Label: 'Datum der Bestellung', 
    Quickinfo: 'Datum der Bestellung'
  }
  OrderDate,
  @Endusertext: {
    Label: 'Summe der Bestellung', 
    Quickinfo: 'Summe der Bestellung'
  }
  @Semantics: {
    Amount.Currencycode: 'Currency'
  }
  OrderTotal,
  @Endusertext: {
    Label: 'Rabat', 
    Quickinfo: 'Rabat'
  }
  Discount,
  @Endusertext: {
    Label: 'Info', 
    Quickinfo: 'Info'
  }
  Info,
  @Endusertext: {
    Label: 'Status Bestellung', 
    Quickinfo: 'Status der Bestellung (BO, BB, BA, BN)'
  }
  Status,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  @Endusertext: {
    Label: 'Währung', 
    Quickinfo: 'Währung'
  }
  Currency,
  @Endusertext: {
    Label: 'Created By', 
    Quickinfo: 'Created By User'
  }
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Endusertext: {
    Label: 'Created On', 
    Quickinfo: 'Creation Date Time'
  }
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Endusertext: {
    Label: 'Changed By', 
    Quickinfo: 'Local Instance Last Changed By User'
  }
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Endusertext: {
    Label: 'Changed On', 
    Quickinfo: 'Local Instance Last Change Date Time'
  }
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Endusertext: {
    Label: 'Changed On', 
    Quickinfo: 'Last Change Date Time'
  }
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _Customer_M : redirected to parent ZC_04_17_CUSTOMER_M000,
  _BaseEntity
}
