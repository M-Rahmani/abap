@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_CS04_CUSTOMER as select from zcs04_customers as Customer
composition [0..*] of ZR_CS04_Orders as _Orders
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
  sales_volume_target as SalesVolumeTarget,
  change_rate_date as ChangeRateDate,
  fax as Fax,
  phone as Phone,
  email as Email,
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
    _Orders
}


