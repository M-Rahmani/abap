@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Count'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCS04_OrderCount with parameters CustID : zcustomerid04   
as select from zcs04_custorders 
{    
      count( * ) as OrderCount 
}
where customerid = $parameters.CustID

