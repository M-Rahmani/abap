INTERFACE zif_cs17_statistic
  PUBLIC .

  METHODS :
   AverageSales
    IMPORTING
      i_Customerid  TYPE   zcustomerid04
    RETURNING
      VALUE(Sales_AVG) TYPE zsales_volume04
    RAISING
      cx_static_check,
    MaxSales
     IMPORTING
       i_Customerid  TYPE  zcustomerid04
     RETURNING
       VALUE(Sales_MAX) TYPE zsales_volume04
     RAISING
       cx_static_check,
    DaySales
     RETURNING
       VALUE(Sales_DAY) TYPE zsales_volume04
     RAISING
       cx_static_check
      .
ENDINTERFACE.
