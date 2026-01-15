CLASS LHC_ZR_CS15CUSTOMERS DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrCs15customers
        RESULT result,
      cancelorders FOR MODIFY
            IMPORTING keys FOR ACTION ZrCs15customers~cancelorders,
      ShowStatistics FOR MODIFY
            IMPORTING keys FOR ACTION ZrCs15customers~ShowStatistics.
ENDCLASS.

CLASS LHC_ZR_CS15CUSTOMERS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD cancelorders.

  DATA lv_customer TYPE zcs15customers-customerid.


  lv_customer = keys[ 1 ]-Customerid.


  DATA lt_orders   TYPE TABLE FOR UPDATE ZR_CS15CUSTORDERS.

  " 1. Берём Customer из keys
  lv_customer = keys[ 1 ]-Customerid.

  " 2. Читаем заказы клиента
  READ ENTITIES OF ZR_CS15CUSTORDERS
    ENTITY ZR_CS15CUSTORDERS
    ALL FIELDS
    WITH VALUE #(
      ( Customerid = lv_customer )
    )
    RESULT DATA(lt_read).

  " 3. Готовим изменения (Storno)
  LOOP AT lt_read ASSIGNING FIELD-SYMBOL(<ls_order>).
    <ls_order>-Status = 'C'.
*    APPEND <ls_order> TO lt_orders.
  ENDLOOP.

  " 4. Обновляем через RAP
*  MODIFY ENTITIES OF ZR_CS04_CUSTORDERS
**    ENTITY CustOrders
*    UPDATE FROM lt_orders
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).


  ENDMETHOD.

  METHOD ShowStatistics.
  ENDMETHOD.

ENDCLASS.
