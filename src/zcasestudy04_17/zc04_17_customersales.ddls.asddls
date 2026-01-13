@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'List of sales_Price of Customer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE

define view entity ZC04_17_CustomerSales
  as select from ZR_CS04_CUSTOMERS as Customer
  association to ZR_CS04_CUSTORDERS  as _CustoRder
    on _CustoRder.Customerid = Customer.Customerid
{
  key Customer.Customerid  as Customerid,
      Customer.Company    as CustomerName,
      Customer.Postcode as PLZ,
      _CustoRder.Orderid as OrderId,
      @Semantics.amount.currencyCode: 'Currency'
      _CustoRder.OrderTotal  as TotalRevenue,
      _CustoRder.Currency       as Currency,
     _CustoRder
      
}


