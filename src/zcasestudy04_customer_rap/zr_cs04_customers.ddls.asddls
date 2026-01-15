@AccessControl.authorizationCheck: #CHECK //#MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS04_CUSTOMERS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CS04_CUSTOMERS
  as select from zcs04_customers
  association [0..*] to ZR_CS04_POSTCODE as _Postcodes on $projection.Postcode = _Postcodes.Postcode
{
  key customerid as Customerid,
  salutation as Salutation,
  last_name as LastName,
  first_name as FirstName,
  company as Company,
  street as Street,
  city as City,
  country as Country,
  postcode as Postcode,
  acc_lock as AccLock,
  last_date as LastDate,
  @Semantics.amount.currencyCode: 'Currency'
  sales_volume as SalesVolume,
  @Semantics.amount.currencyCode: 'CurrencyTarget'
//  @EndUserText.label: 'SalesVolumeTarget'
//  currency_conversion(
//    client => $session.client,
//    amount => $projection.SalesVolume,
//    round => '',
//    source_currency => $projection.Currency,
//    target_currency => $projection.CurrencyTarget,
//    exchange_rate_type => cast('M' as abap.char(4)),
//    exchange_rate_date => case
//                              when $projection.ChangeRateDate is initial
//                              then $session.system_date
//                              else $projection.ChangeRateDate
//                            end ) as SalesVolumeTarget,
  sales_volume_target as SalesVolumeTarget,
  change_rate_date as ChangeRateDate,
  fax as Fax,
  phone as Phone,
  email as Email,
  @UI.identification: [ {
    position: 180 , type: #WITH_URL, url: 'Url' 
  } ]
  @UI.lineItem: [ {
    position: 180 , type:  #WITH_URL, url: 'Url'  
  } ]
  @UI.selectionField: [ {
    position: 180 
  } ]
  url as Url,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency_target as CurrencyTarget,
  language as Language,
  weblogin as Weblogin,
  webpw as Webpw,
  memo as Memo,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _Postcodes
}
