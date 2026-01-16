@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custorders master slave'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcs15Custorders_MS as select from zcs15custorders
association to parent zcs15Customers_root as _zcs15customers_ms
    on $projection.Customerid = _zcs15customers_ms.Customerid
{
    key customerid as Customerid,
    key orderid as Orderid,
    order_date as OrderDate,
//    @Semantics.amount.currencyCode : 'zcs15_custorders.Currency' 
    
//    order_total as OrderTotal,
    discount as Discount,
    info as Info,
    status as Status,
    currency as Currency,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    _zcs15customers_ms // Make association public
}
