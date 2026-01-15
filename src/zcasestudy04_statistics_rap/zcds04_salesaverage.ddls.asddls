@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales average'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS04_SALESAVERAGE 
  as select from ZI_CS04_CUSTORDERS as Custorder
  association to zcs04_customize  as _FiscalYear on  $projection.Orderyear = _FiscalYear.cvalue
//  association [0..1] to ZR_CS04_CUSTOMERS as _Customer on  $projection.Customer = _Customer.Customerid
{
  Custorder.Customerid                                           as Customer,
  @Semantics.calendar.year: true
  Orderyear                                                      as Orderyear,
  @Semantics.amount.currencyCode: 'currency'
  cast(
     sum( cast( OrderTotalEUR as  abap.fltp ) ) / cast( count( distinct Orderid ) as abap.fltp )
    as abap.curr( 15, 2 )
  )                                                              as SalesAVG,
  Custorder.TargetCurrency as Currency
}  
where
     Status <> 'BS'
 and upper(_FiscalYear.cname) = 'FISCALYEAR'
 and ((OrderTotalEUR <> 0) or (OrderTotalEUR is not initial))
group by
  Customerid,
  Orderyear,
  TargetCurrency

