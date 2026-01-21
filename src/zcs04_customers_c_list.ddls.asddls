@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Liste der Umsätze'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcs04_customers_c_list as select from zcs04customers_r as c
 left outer join zcs04custorders_wo_parameter_r as co on
c.Customerid = co.Customerid
{
    key c.Customerid,
    c.Company,
   co.Orderid,
    @Semantics.amount.currencyCode : 'Currency'
   co.OrderTotal,
   co.Currency,
   co.Status
    /* Associations */
    
} 

