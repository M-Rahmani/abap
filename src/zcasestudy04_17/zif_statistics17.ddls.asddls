@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STATISTICS Rep'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIF_STATISTICS17
  as select from ZI_CS04_CUSTORDERS as Custorder
  association [0..1] to ZR_CS04_CUSTOMERS as _Customer on  $projection.Customer = _Customer.Customerid
//  association        to zcs04_max_umsatz  as _Maxsales on  Custorder.Customerid = _Maxsales.Customerid
//                                                       and $projection.currency = _Maxsales.Currency
{

  Custorder.Customerid                                           as Customer,
  _Customer.Company                                              as Company,
  concat_with_space( _Customer.FirstName, _Customer.LastName, 1) as Name,
  @Semantics.calendar.year: true
  Orderyear                                                      as Orderyear,
  //   @Semantics.amount.currencyCode: 'currency'
  //    sum( OrderTotal ) as TotalSales,
  //    count( distinct ( Orderid ) ) as OrderCount,
  @Semantics.amount.currencyCode: 'currency'
  cast(
     sum( cast( OrderTotal as  abap.fltp ) ) / cast( count( distinct Orderid ) as abap.fltp )
    as abap.curr( 15, 2 )
  )                                                              as SalesAVG,
//  @Semantics.amount.currencyCode: 'currency'
//  _Maxsales.MaxOrderTotal                                        as Max_Sales,
  Currency                                                       as currency
}  
where
  Status <> 'BS'
group by
  Customerid,
  _Customer.Company,
  _Customer.FirstName,
  Orderyear,
  _Customer.LastName,
  Currency
//  _Maxsales.MaxOrderTotal
