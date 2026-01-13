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
            IMPORTING keys FOR ACTION ZrCs04Customers000~CancelOrders.
ENDCLASS.

CLASS LHC_ZR_CS04_CUSTOMERS000 IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
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
  ENDMETHOD.

ENDCLASS.
