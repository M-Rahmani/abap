@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STATISTICS Rep'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIF_STATISTICS2_17
  as select from ZI_CS04_CUSTORDERS as Custorder
{
//  case Orderyear 
//  datn_days_between( $session.user_date, concat( '0101' , Orderyear ) ) as Between_Days,
 // @Semantics.calendar.year: true
  Orderyear                                                      as Orderyear
  //   @Semantics.amount.currencyCode: 'currency'
  //    sum( OrderTotal ) as TotalSales,
  //    count( distinct ( Orderid ) ) as OrderCount,
//  @Semantics.amount.currencyCode: 'currency'
//  cast(
//     sum( cast( OrderTotal as  abap.fltp ) ) / cast( count( distinct Orderid ) as abap.fltp )
//    as abap.curr( 15, 2 )
//  )                                                              as SalesAVG,
//  @Semantics.amount.currencyCode: 'currency'
//  _Maxsales.MaxOrderTotal                                        as Max_Sales,
//  Currency                                                       as currency
}
//where
 // Status <> 'BS'
//group by
  //Orderyear,
//  Currency
//  _Maxsales.MaxOrderTotal
