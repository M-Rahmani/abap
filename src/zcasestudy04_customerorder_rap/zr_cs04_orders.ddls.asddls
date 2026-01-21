@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Orders'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_CS04_Orders as select from  zcs04_custorders as Orders
association to parent ZR_CS04_CUSTOMER as _Customer on $projection.Customerid = _Customer.Customerid
association [0..1] to zi_zdstatus04Text as _StatusText
    on  _StatusText.value_low = Orders.status
    and _StatusText.language  = $session.system_language
{
  key customerid as Customerid,
  key orderid as Orderid,
  order_date as OrderDate,
  @Semantics.amount.currencyCode: 'Currency'
  order_total as OrderTotal,
  discount as Discount,
  info as Info,
  @ObjectModel.text.association: '_StatusText'
  status as Status,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
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
  _Customer,
  _StatusText
}
    
