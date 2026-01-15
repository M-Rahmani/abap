@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales average'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS17_SALESDaily
  as select from ZI_CS04_CUSTORDERS as Custorder
  association to zcs04_customize as _FiscalYear on $projection.Orderyear = _FiscalYear.cvalue
{
  @Semantics.calendar.year: true
  Orderyear                                                as Orderyear,
  @Semantics.amount.currencyCode: 'currency'
  case
  when cast( max( dats_days_between( cast( concat( _FiscalYear.cvalue, '0101' ) as abap.dats ),
         cast( OrderDate as abap.dats ) ) ) as abap.int4 )  = 0 then 0
  else cast(
     sum( cast( OrderTotal as  abap.fltp ) ) / cast( max( dats_days_between( cast( concat( _FiscalYear.cvalue, '0101' )
     as abap.dats ),
         cast( OrderDate as abap.dats ) ) ) as abap.fltp )
    as abap.dec( 15, 2 )
  )
  end                                                      as SalesDaily,
  Custorder.Currency                                       as Currency
}
where
  Status                   <> 'BS'
  and upper(_FiscalYear.cname) =  'FISCALYEAR'
  and(
    (
      OrderTotal               <> 0
    )
    or(
      OrderTotal               is not initial
    )
  )
group by
  Orderyear,
  Currency
