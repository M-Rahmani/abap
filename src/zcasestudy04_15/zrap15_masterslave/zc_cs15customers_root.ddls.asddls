@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'customers root'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS15CUSTOMERS_ROOT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZCS15CUSTOMERS_ROOT
  association [1..1] to ZCS15CUSTOMERS_ROOT as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID
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
  @Endusertext: {
    Label: 'Währung', 
    Quickinfo: 'Währung'
  }
  Currency,
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
  _orders : redirected to composition child ZC_CS15CUSTORDERS_MS000,
  _BaseEntity
}
