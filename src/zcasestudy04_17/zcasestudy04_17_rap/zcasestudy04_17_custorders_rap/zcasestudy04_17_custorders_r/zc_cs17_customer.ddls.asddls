@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'Customer'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS17_CUSTOMER
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS17_CUSTOMER
  association [1..1] to ZR_CS17_CUSTOMER as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID
{
  @Endusertext: {
    Label: 'Kundennummer', 
    Quickinfo: 'CustomerID'
  }
  key Customerid,
  @Endusertext: {
    Label: 'Anrede', 
    Quickinfo: 'Anrede'
  }
  Salutation,
  @Endusertext: {
    Label: 'Last_Name', 
    Quickinfo: 'Last_Name'
  }
  LastName,
  @Endusertext: {
    Label: 'First Name', 
    Quickinfo: 'First_Name'
  }
  FirstName,
  @Endusertext: {
    Label: 'Company', 
    Quickinfo: 'Company'
  }
  Company,
  @Endusertext: {
    Label: '', 
    Quickinfo: 'Street'
  }
  Street,
  @Endusertext: {
    Label: '', 
    Quickinfo: 'City'
  }
  City,
  @Endusertext: {
    Label: 'Country/Region', 
    Quickinfo: 'Company Country/Region'
  }
  Country,
  @Endusertext: {
    Label: 'Postcode', 
    Quickinfo: 'Postcode'
  }
  Postcode,
  @Endusertext: {
    Label: 'buch Sper', 
    Quickinfo: 'buchhalterische Sperre'
  }
  AccLock,
  @Endusertext: {
    Label: 'ÄnderungStammsatzes', 
    Quickinfo: 'letzte Änderung des Stammsatzes'
  }
  LastDate,
  @Endusertext: {
    Label: 'Summe Gesamtumsatzes', 
    Quickinfo: 'Summe des Gesamtumsatzes'
  }
  @Semantics: {
    Amount.Currencycode: 'Currency'
  }
  SalesVolume,
  @Endusertext: {
    Label: 'Gesamtumsatz Zielwäh', 
    Quickinfo: 'Gesamtumsatz Zielwährung'
  }
  @Semantics: {
    Amount.Currencycode: 'CurrencyTarget'
  }
  SalesVolumeTarget,
  @Endusertext: {
    Label: 'Umrechnungsdatum', 
    Quickinfo: 'Umrechnungsdatum'
  }
  ChangeRateDate,
  @Endusertext: {
    Label: 'Fax', 
    Quickinfo: 'Fax'
  }
  Fax,
  @Endusertext: {
    Label: 'Phone', 
    Quickinfo: 'Phone'
  }
  Phone,
  @Endusertext: {
    Label: 'E-Mail Adresse', 
    Quickinfo: 'E-Mail Adresse'
  }
  Email,
  @Endusertext: {
    Label: 'URL Adresse', 
    Quickinfo: 'URL Adresse'
  }
  Url,
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
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  @Endusertext: {
    Label: 'Zielwährung', 
    Quickinfo: 'Zielwährung'
  }
  CurrencyTarget,
  @Endusertext: {
    Label: 'Language Key', 
    Quickinfo: 'Language Key'
  }
  Language,
  @Endusertext: {
    Label: 'Weblogin für Kund', 
    Quickinfo: 'Weblogin für Kundendaten'
  }
  Weblogin,
  @Endusertext: {
    Label: 'Webpass für Kund', 
    Quickinfo: 'Webpassword für Kundendaten'
  }
  Webpw,
  @Endusertext: {
    Label: 'All Info', 
    Quickinfo: 'Allgemeine Informationen'
  }
  Memo,
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
  _Orders : redirected to composition child ZC_CS17_ORDERS,
  _BaseEntity
}
