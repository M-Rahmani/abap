@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maximaler Umsatz pro Kunde'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcs04_max_umsatz as select from zcs04_customers_c_list
{
   
//    Orderid,
    Customerid,
    Company,
   @Semantics.amount.currencyCode : 'Currency'
   max( OrderTotal) as MaxOrderTotal,
    Currency

}  group by Currency, Customerid, Company
