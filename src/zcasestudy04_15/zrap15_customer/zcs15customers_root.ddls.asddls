@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'customers root'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zcs15Customers_root 
  as select from zcs15customers
  composition [1..*] of zcs15Custorders_MS as _orders
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
//    sales_volume as SalesVolume,
//    sales_volume_target as SalesVolumeTarget,
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
    _orders // Make association public
}
