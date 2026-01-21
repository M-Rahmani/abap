@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales average'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS04_SALESDAILY
  as select from ZI_CS04_CUSTORDERS as Custorder
  association to zcs04_customize as _FiscalYear on $projection.Orderyear = _FiscalYear.cvalue
{
  @Semantics.calendar.year: true
  Orderyear                                                as Orderyear,
  @Semantics.amount.currencyCode: 'currency'
  case
  when cast( ( dats_days_between( cast( concat( _FiscalYear.cvalue, '0101' ) as abap.dats ),
         cast( $session.system_date as abap.dats ) ) + 1 ) as abap.int4 )  = 0 then 0
  else cast(
     sum( cast( OrderTotalEUR as  abap.fltp ) ) / cast( ( dats_days_between( cast( concat( _FiscalYear.cvalue, '0101' )
     as abap.dats ),
         cast( $session.system_date as abap.dats ) ) + 1 ) as abap.fltp )
    as abap.dec( 15, 2 )
  )
  end                                                      as SalesDaily,
  Custorder.TargetCurrency                                  as Currency
}
where
  Status                   <> 'BS'
  and upper(_FiscalYear.cname) =  'FISCALYEAR'
  and(
    (
      OrderTotalEUR               <> 0
    )
    or(
      OrderTotalEUR               is not initial
    )
  )
group by
  Orderyear,
  _FiscalYear.cvalue,
  TargetCurrency
