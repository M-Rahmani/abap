@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Test CDS View Bestellungen'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zcs04_16_custorders_r_test with parameters p_custID: zcustomerid04 
as select from zcs04_custorders 
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
    last_changed_at as LastChangedAt
}
where $parameters.p_custID = customerid
