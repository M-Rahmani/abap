@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'Custorders master slave'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_CS15CUSTORDERS_MS000
  as projection on ZCS15CUSTORDERS_MS
  association [1..1] to ZCS15CUSTORDERS_MS as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID and $projection.ORDERID = _BaseEntity.ORDERID
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
  @Endusertext: {
    Label: 'Währung', 
    Quickinfo: 'Währung'
  }
  Currency,
  @Endusertext: {
    Label: 'Created By', 
    Quickinfo: 'Created By User'
  }
  LocalCreatedBy,
  @Endusertext: {
    Label: 'Created On', 
    Quickinfo: 'Creation Date Time'
  }
  LocalCreatedAt,
  @Endusertext: {
    Label: 'Changed By', 
    Quickinfo: 'Local Instance Last Changed By User'
  }
  LocalLastChangedBy,
  @Endusertext: {
    Label: 'Changed On', 
    Quickinfo: 'Local Instance Last Change Date Time'
  }
  LocalLastChangedAt,
  @Endusertext: {
    Label: 'Changed On', 
    Quickinfo: 'Last Change Date Time'
  }
  LastChangedAt,
  _zcs15customers_ms : redirected to parent ZC_CS15CUSTOMERS_ROOT,
  _BaseEntity
}
