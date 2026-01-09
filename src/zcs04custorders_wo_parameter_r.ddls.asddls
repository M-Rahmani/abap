@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: ' Bestellungen ohne Parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcs04custorders_wo_parameter_r as select from zcs04_custorders
 association [1..1] to zcs04customers_r as _customer on $projection.Customerid = _customer.Customerid
{
    key customerid as Customerid,
    key orderid as Orderid,
    order_date as OrderDate,
     @Semantics.amount.currencyCode : 'Currency'
    order_total as OrderTotal,
    discount as Discount,
    info as Info,
    status as Status,
    currency as Currency,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    _customer
}
