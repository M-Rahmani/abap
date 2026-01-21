@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Customer'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS04_CUSTOMER
  provider contract transactional_query
  as projection on ZR_CS04_CUSTOMER
  association [1..1] to ZR_CS04_CUSTOMER as _BaseEntity on $projection.Customerid = _BaseEntity.Customerid
{
  @EndUserText: {
    label: 'Kundennummer', 
    quickInfo: 'CustomerID'
  }
  key Customerid,
  @EndUserText: {
    label: 'Anrede', 
    quickInfo: 'Anrede'
  }
  Salutation,
  @EndUserText: {
    label: 'Last_Name', 
    quickInfo: 'Last_Name'
  }
  LastName,
  @EndUserText: {
    label: 'First Name', 
    quickInfo: 'First_Name'
  }
  FirstName,
  @EndUserText: {
    label: 'Company', 
    quickInfo: 'Company'
  }
  Company,
  @EndUserText: {
    label: '', 
    quickInfo: 'Street'
  }
  Street,
  @EndUserText: {
    label: '', 
    quickInfo: 'City'
  }
  City,
  @EndUserText: {
    label: 'Country/Region', 
    quickInfo: 'Company Country/Region'
  }
  Country,
  @EndUserText: {
    label: 'Postcode', 
    quickInfo: 'Postcode'
  }
  Postcode,
  @EndUserText: {
    label: 'buch Sper', 
    quickInfo: 'buchhalterische Sperre'
  }
  AccLock,
  @EndUserText: {
    label: 'ÄnderungStammsatzes', 
    quickInfo: 'letzte Änderung des Stammsatzes'
  }
  LastDate,
  @EndUserText: {
    label: 'Summe Gesamtumsatzes', 
    quickInfo: 'Summe des Gesamtumsatzes'
  }
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  SalesVolume,
  @EndUserText: {
    label: 'Gesamtumsatz Zielwäh', 
    quickInfo: 'Gesamtumsatz Zielwährung'
  }
  @Semantics: {
    amount.currencyCode: 'CurrencyTarget'
  }
  SalesVolumeTarget,
  @EndUserText: {
    label: 'Umrechnungsdatum', 
    quickInfo: 'Umrechnungsdatum'
  }
  ChangeRateDate,
  @EndUserText: {
    label: 'Fax', 
    quickInfo: 'Fax'
  }
  Fax,
  @EndUserText: {
    label: 'Phone', 
    quickInfo: 'Phone'
  }
  Phone,
  @EndUserText: {
    label: 'E-Mail Adresse', 
    quickInfo: 'E-Mail Adresse'
  }
  Email,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CS4_CUST_UTILITIES' 
  @EndUserText.label: 'order count'
  virtual ordercount : abap.int4,
  @EndUserText: {
    label: 'URL Adresse', 
    quickInfo: 'URL Adresse'
  }
  Url,
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
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  @EndUserText: {
    label: 'Zielwährung', 
    quickInfo: 'Zielwährung'
  }
  CurrencyTarget,
  @EndUserText: {
    label: 'Language Key', 
    quickInfo: 'Language Key'
  }
  Language,
  @EndUserText: {
    label: 'Weblogin für Kund', 
    quickInfo: 'Weblogin für Kundendaten'
  }
  Weblogin,
  @EndUserText: {
    label: 'Webpass für Kund', 
    quickInfo: 'Webpassword für Kundendaten'
  }
  Webpw,
  @EndUserText: {
    label: 'All Info', 
    quickInfo: 'Allgemeine Informationen'
  }
  Memo,
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
  _Orders : redirected to composition child ZC_CS04_ORDERS,
  _BaseEntity
}
