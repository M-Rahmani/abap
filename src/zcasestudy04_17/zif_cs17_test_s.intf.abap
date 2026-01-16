INTERFACE zif_cs17_test_s
  PUBLIC .
  INTERFACES if_badi_interface .
  METHODS :
   AverageSales
    IMPORTING
      i_Customerid  TYPE   zcustomerid04
    CHANGING
      Sales_AVG TYPE  zsales_volume04,
    MaxSales
     IMPORTING
       i_Customerid  TYPE  zcustomerid04
     CHANGING
       Sales_MAX TYPE zsales_volume04,
    DaySales
     CHANGING
       Sales_DAY TYPE zsales_volume04
      .
ENDINTERFACE.
