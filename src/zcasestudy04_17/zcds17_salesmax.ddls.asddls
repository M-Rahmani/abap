@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales average'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS17_SALESMAX 
  as select from ZI_CS04_CUSTORDERS as Custorder
{
  Custorder.Customerid    as Customer,
  @Semantics.amount.currencyCode: 'currency'
  cast(
     max( cast( OrderTotal as  abap.fltp ) ) as abap.curr( 15, 2 )
     )   as SalesMAX,
  Custorder.Currency as Currency
}  
where
     Status <> 'BS'
 and ((OrderTotal <> 0) or (OrderTotal is not initial))
group by
  Customerid,
  Orderyear,
  Currency
