@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS04_CUSTOMERS'
}
@AccessControl.authorizationCheck: #CHECK

define root view entity ZC_CS04_CUSTOMERS000
  provider contract transactional_query
  as projection on ZR_CS04_CUSTOMERS
  association [1..1] to ZR_CS04_CUSTOMERS as _BaseEntity on $projection.Customerid = _BaseEntity.Customerid

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
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CS4_CUST_UTILITIES' //ZCL_CS4_CUST_UTILITIES
  @EndUserText.label: 'order count'
  virtual ordercount : abap.int4,
  Url,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
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
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZBP_C_CS04_CUSTOMERS'
//  @EndUserText.label: 'Count of Orders : '
//  virtual CountofOrders : abap.int2,
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
  _Postcodes : redirected to ZC_CS04_POSTCODE
}
