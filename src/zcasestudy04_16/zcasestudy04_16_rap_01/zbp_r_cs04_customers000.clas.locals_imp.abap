CLASS LHC_ZR_CS04_CUSTOMERS000 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrCs04Customers000
        RESULT result,
      validate_email FOR VALIDATE ON SAVE
            IMPORTING keys FOR ZrCs04Customers000~validate_email,
      CancelOrders FOR MODIFY
            IMPORTING keys FOR ACTION ZrCs04Customers000~CancelOrders,
      ShowStatistics FOR MODIFY
            IMPORTING keys FOR ACTION ZrCs04Customers000~ShowStatistics.

            class-methods:
            SetCancel_Orders IMPORTING Customer_id      TYPE zcustomerid04
                                 Order_id         TYPE zorderid04
                       EXPORTING NumberofUpdating TYPE int2
                                 UMessage         TYPE char72.
*                               max_umsatz Type zorder_total04.

ENDCLASS.

CLASS LHC_ZR_CS04_CUSTOMERS000 IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

 METHOD SetCancel_Orders.
    NumberofUpdating = 0.
    CLEAR UMessage.
    DATA: update_Status TYPE TABLE FOR UPDATE zr_cs04_custorders,
          ls_OrderNo    TYPE zr_cs04_custorders.
    TRY.
        SELECT max( ordertotal ) as maxumsatz, currency FROM zr_cs04_custorders
         WHERE Customerid = @Customer_id
          AND status NOT IN ( 'BS' ) group by currency INTO @Data(max_umsatz).
*          APPEND VALUE #( Customerid = ls_OrderNo-Customerid Orderid = ls_OrderNo-Orderid status = 'BS' ) TO update_Status.
*          IF update_Status IS NOT INITIAL.
*            MODIFY ENTITIES OF zr_cs04_custorders
*                ENTITY ZrCs04Custorders
*                UPDATE FIELDS ( Status ) WITH update_Status
*                REPORTED DATA(reported_records)
*                FAILED   DATA(failed).
*          ENDIF.
*          UPDATE zcs04_custorders SET status = 'BS'
*            WHERE Customerid = @Customer_id
*             AND  orderid   = @OrderNo.
          NumberofUpdating += 1.
         ENDSELECT.
      CATCH cx_root INTO DATA(ls_exception).
        UMessage = ls_exception->get_longtext(  ).
    ENDTRY.
  ENDMETHOD.


  METHOD validate_email.

   read entities of zr_cs04_customers000 in local mode
    ENTITY  ZrCs04Customers000 "zr_cs04_customers000
    FIELDS ( Email )
    with CORRESPONDING #( keys )
    RESULT DATA(customers).

   LOOP at customers ASSIGNING FIELD-SYMBOL(<cust>).

   data(lv_email) = <cust>-Email.

    data e_Result type abap_bool  value abap_true.
    DATA: lv_pattern TYPE string VALUE
            '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$',
          lo_matcher TYPE REF TO cl_abap_matcher.

*    e_result  = abap_true.
*    CLEAR e_message.
*    new_email = i_customer-email.

   IF lv_email IS NOT INITIAL.
   try.
      lo_matcher = cl_abap_matcher=>create(
        pattern = lv_pattern
        text    = lv_email
      ).
catch cx_root.
      endtry.
      IF lo_matcher->match( ) = abap_false.
      reported-zrcs04customers000 = value #( (  %tky = <cust>-%tky
                                        %msg = new_message(
                                         id = 'ZMSG15'
                                         number = '001'
                                         severity = if_abap_behv_message=>severity-warning
                                         v1 = <cust>-email  ) ) ).
*        e_message = 'Email has invalid format'.
*        e_result  = abap_false.
      ENDIF.
    ENDIF.


**   if <cust>-Email is initial or <cust>-Email NP '*@*.*'.
*   if lv_email NP '*@*.*'.
*
*
*
**   failed-zcs04_copy_d = value #(
**        ( %tky = <cust>-%tky )
**        ).
*
*   reported-zrcs04customers000 = value #( (  %tky = <cust>-%tky
*                                        %msg = new_message(
*                                         id = 'ZMSG15'
*                                         number = '001'
*                                         severity = if_abap_behv_message=>severity-warning
*                                         v1 = <cust>-email  ) ) ).
*
*     contiNUE.
*    endif.
*   if lv_email CA  ' !#$%&()*+,/:;>=<?{}?\|''"'.
*
**   failed-zcs04_copy_d = value #(
**        ( %tky = <cust>-%tky )
**        ).
*
*   reported-zrcs04customers000 = value #( (  %tky = <cust>-%tky
*                                        %msg = new_message(
*                                         id = 'ZMSG15'
*                                         number = '002'
*                                         severity = if_abap_behv_message=>severity-warning
*                                         v1 = <cust>-email  ) ) ).
*
*     contiNUE.
*    endif.

    endloop.


  ENDMETHOD.

  METHOD CancelOrders.

  read entities of zr_cs04_custorders "in local mode
    ENTITY  ZrCs04Custorders
    FIELDS ( customerid status )
    with CORRESPONDING #( keys )
    RESULT DATA(custorders).

loop at custorders into data(custorder).

 select single
 from zcs04_custorders
 fields status
 where customerid = @custorder-Customerid "and @custorder-status <> 'BA'
 into @custorder-status.

 custorder-status = 'BS'.

 Modify custorders from custorder.
endloop.

data custorders_upd type table for update zr_cs04_custorders.
custorders_upd = corresponding #( custorders ).

modify entities of zr_cs04_custorders
entity ZrCs04Custorders
update
fields ( status )
with custorders_upd reported data(reported_records).
*
*reported-zrcs04customers000 =  corresponding #( reported_records-zrcs04custorders ).

*data(custid) = key-%param-customerid.

*  modify entities of zr_cs04_custorders "in LOCAL MODE
*    ENTITY  ZrCs04Custorders "zr_cs04_customers000
*    update FIELDS ( Status )
*    with value #(
* for key in keys (
*    Customerid = key-%param-customerid
*                                    Status = 'BS' )   )
*                                    reported data(reported_status)
*                                    failed data(failed_status).

*data custorders type table of zcs04_custorders.
*data custorder type  zcs04_custorders.

 ENDMETHOD.


  METHOD ShowStatistics.
 DATA : Up_Count      TYPE int2,
           UP_Message    TYPE char72,
           failed_record LIKE LINE OF failed-zrcs04customers000.
    TRY.
      LOOP AT keys INTO DATA(Custpomer) .
      SELECT customerid, max( ordertotal ) as maxumsatz, currency FROM zr_cs04_custorders
         WHERE Customerid = @Custpomer-Customerid
          AND status NOT IN ( 'BS' ) group by currency, customerid INTO @Data(max_umsatz).
          endselect.

    data newyear type zorder_total04 value 20260101.

*          select customerid , avg( ordertotal ) as averageSales , currency from zr_cs04_custorders
*         where   Customerid = @Custpomer-Customerid and ordertotal > 0 and ordertotal is not initial and OrderDate >=  @newyear
*         group by currency, customerid  into @data(avSales) .
*             endselect.

           data g_date type zorder_date04.
           data daysales type zorder_total04.
           data days type i.
         g_date = cl_abap_context_info=>get_system_date( ).
         days = g_date - 20260101.

         select  sum( ordertotal ) as sumSales from zr_cs04_custorders
         where    OrderDate >= @newyear  AND status NOT IN ( 'BS' )
          into @daySales .

            daysales = daysales / days.

*          loop at max_umsatz.
          APPEND VALUE #(
                          %msg = new_message( id = 'ZCS04_MSG'
                                          number = '008'
                                         severity = if_abap_behv_message=>severity-information
                                         v1 = max_umsatz-customerid
                                          v2 = max_umsatz-maxumsatz
*                                           v3 = avsales-averagesales
*                                           v4 = daysales
                                            )
                         ) TO reported-zrcs04customers000.


*        setcancel_orders( EXPORTING customer_id = Custpomer-customerid order_id = '' IMPORTING numberofupdating = Up_Count umessage = Up_message ).
*        IF Up_message IS NOT INITIAL.
*          APPEND VALUE #( %cid = Custpomer-%cid
*                          %msg = new_message( id = 'ZCS04_MSG'
*                                          number = '006'
*                                         severity = if_abap_behv_message=>severity-error
*                                         v1 = Up_message
*                                            )
*                         ) TO reported-zrcs04customers000.
*            failed_record-%cid = Custpomer-%cid.
*            APPEND failed_record TO failed-zrcs04customers000.
*        ENDIF.
      ENDLOOP.
**        result = VALUE #( FOR customer IN Custpomers ( %cid = Custpomer-%cid %param = customer ) ).
       CATCH cx_root INTO DATA(ls_exception).
*        APPEND VALUE #( %cid = Custpomer-%cid
*                        %msg = new_message( id = 'ZCS04_MSG'
*                                            number = '006'
*                                            severity = if_abap_behv_message=>severity-error
*                                            v1 = ls_exception->get_longtext(  )
*                                            )
*                          ) TO reported-zrcs04customers000.
    ENDTRY.


  ENDMETHOD.

ENDCLASS.
