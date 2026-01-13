CLASS LHC_ZR_CS15_CUSTOMERS DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrCs15Customers
        RESULT result,
      cancelOrders FOR MODIFY
            IMPORTING keys FOR ACTION ZrCs15Customers~cancelOrders RESULT result.
ENDCLASS.

CLASS LHC_ZR_CS15_CUSTOMERS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD cancelOrders.

  " keys — это таблица с ключами записей, которые нужно изменить
  LOOP AT keys INTO DATA(ls_key).

    DATA(lv_customer) = ls_key-customerid.

    " Сторно всех заказов клиента
    DELETE FROM zcs15_custorders
      WHERE customerid = @lv_customer.


 APPEND VALUE #( customerid = lv_customer ) TO result.



endloop.


  ENDMETHOD.

ENDCLASS.
