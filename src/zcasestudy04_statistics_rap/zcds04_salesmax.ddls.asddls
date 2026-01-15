@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales average'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS04_SALESMAX 
  as select from ZI_CS04_CUSTORDERS as Custorder
{
  Custorder.Customerid    as Customer,
  @Semantics.amount.currencyCode: 'currency'
  cast(
     max( cast( OrderTotalEUR as  abap.fltp ) ) as abap.curr( 15, 2 )
     )   as SalesMAX,
  Custorder.TargetCurrency as Currency
}  
where
     Status <> 'BS'
 and ((OrderTotalEUR <> 0) or (OrderTotalEUR is not initial))
group by
  Customerid,
  TargetCurrency
