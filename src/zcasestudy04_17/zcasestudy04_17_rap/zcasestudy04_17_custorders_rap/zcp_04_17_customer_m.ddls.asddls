@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Master'
@Metadata.ignorePropagatedAnnotations: true
define root view entity  ZCP_04_17_Customer_M
provider contract transactional_query
  as projection on ZC_04_17_Customer_M
{
  key Customerid,
  Salutation,
  LastName,
  FirstName,
  Company,
  Street,
  City,
  Country,
  Postcode,
  AccLock,
  LastDate,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  SalesVolume,
  @Semantics: {
    amount.currencyCode: 'CurrencyTarget'
  }
  SalesVolumeTarget,
  ChangeRateDate,
  Fax,
  Phone,
  Email,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CS4_CUST_UTILITIES' //ZCL_CS4_CUST_UTILITIES
//  @EndUserText.label: 'order count'
//  virtual ordercount : abap.int4,
//  Url,
//  @Consumption: {
//    valueHelpDefinition: [ {
//      entity.element: 'Currency', 
//      entity.name: 'I_CurrencyStdVH', 
//      useForValidation: true
//    } ]
//  }
  Currency,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  CurrencyTarget,
    @Consumption: {
    valueHelpDefinition: [ {
      entity: { name: 'I_Language', element: 'Language' },
      useForValidation: true
    } ]
  }
  Language,
  Weblogin,
  Webpw,
  Memo,
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
  _Orders_D   : redirected to composition child ZCP_04_17_Customer_D
}
