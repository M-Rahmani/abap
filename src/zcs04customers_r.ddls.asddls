//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AbapCatalog: {dataMaintenance: #RESTRICTED, viewEnhancementCategory: [ #PROJECTION_LIST ],
extensibility.dataSources: [ 'customerr' ], extensibility.elementSuffix: 'ZVP'}
@AccessControl.authorizationCheck: #CHECK   //PLZ : 22000-22200
////@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'CDS-View für die Kundendaten'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
}
define view entity zcs04customers_r as select from zcs04_customers as customerr
//association [0..*] to zcs04cust_orders_r as _order on $projection.Customerid = _order.Customerid
association [0..*] to zcs04custorders_wo_parameter_r as _order2 on $projection.Customerid = _order2.Customerid


{
    key customerid as Customerid,
    salutation as Salutation,
    last_name as LastName,
    first_name as FirstName,
    company as Company,
    street as Street,
    city as City,
    country as Country,
    postcode as Postcode,
    acc_lock as AccLock,
    last_date as LastDate,
    @Semantics.amount.currencyCode : 'Currency'
    sales_volume as SalesVolume,
    @Semantics.amount.currencyCode : 'CurrencyTarget'
    sales_volume_target as SalesVolumeTarget,
    change_rate_date as ChangeRateDate,
    fax as Fax,
    phone as Phone,
    email as Email,
    url as Url,
    currency as Currency,
    currency_target as CurrencyTarget,
    language as Language,
    weblogin as Weblogin,
    webpw as Webpw,
    memo as Memo,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
 //   _order,
    _order2

}
