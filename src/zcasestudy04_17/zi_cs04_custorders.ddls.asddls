@AccessControl.authorizationCheck: #NOT_REQUIRED //#MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS04_CUSTORDERS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZI_CS04_CUSTORDERS
  as select from zcs04_custorders
{
  key customerid as Customerid,
  key orderid as Orderid,
  order_date as OrderDate,
  @Semantics.amount.currencyCode: 'Currency'
  order_total as OrderTotal,
  discount as Discount,
  info as Info,
  @Semantics.amount.currencyCode: 'TargetCurrency'
  currency_conversion(
    amount             => order_total,
    source_currency    => currency,
    target_currency    => cast( 'EUR' as abap.cuky ),
    exchange_rate_date => order_date,
    error_handling     => 'SET_TO_NULL'
  ) as OrderTotalEUR,
  cast( 'EUR' as abap.cuky ) as TargetCurrency,
  status as Status,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
   @Semantics.calendar.year: true
  cast(substring(order_date, 1, 4) as abap.char( 4 ))  as Orderyear,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
