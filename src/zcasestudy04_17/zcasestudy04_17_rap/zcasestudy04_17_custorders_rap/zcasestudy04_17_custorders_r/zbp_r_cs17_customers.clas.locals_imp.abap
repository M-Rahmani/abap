CLASS lhc_zr_cs17_cust DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS:
      adjust_numbers REDEFINITION.
ENDCLASS.

CLASS lhc_zr_cs17_cust IMPLEMENTATION.
  METHOD adjust_numbers.
    LOOP AT mapped-customer ASSIGNING FIELD-SYMBOL(<customer>).
      TRY.
          <customer>-customerid = zcl_cs4_importcustomer=>get_customerid( EXPORTING i_object = 'ZCS4_NUR' ).
        CATCH cx_root INTO DATA(ls_exception).
          APPEND VALUE #( %key = <customer>-%key
                          %pid = <customer>-%pid
                          %msg = new_message( id = 'ZCS04_MSG'
                                              number = '002'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = ls_exception->get_longtext(  )
                                              )
                            ) TO reported-customer.
      ENDTRY.
    ENDLOOP.
    LOOP AT mapped-orders ASSIGNING FIELD-SYMBOL(<orders>).
      TRY.
          <orders>-Orderid = zcl_cs4_importcustomer=>get_numberid( EXPORTING i_object = 'ZCS4_Ord' ).
          <orders>-Customerid = <orders>-%tmp-Customerid.
        CATCH cx_root INTO DATA(ls_except).
          APPEND VALUE #( %key = <orders>-%key
                          %pid = <orders>-%pid
                          %msg = new_message( id = 'ZCS04_MSG'
                                              number = '002'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = ls_except->get_longtext(  )
                                              )
                            ) TO reported-orders.
      ENDTRY.
    ENDLOOP.
    LOOP AT mapped-orderitems ASSIGNING FIELD-SYMBOL(<orderitems>).
      TRY.
          <orderitems>-Orderitem = zcl_cs4_importcustomer=>get_OrderItemid( EXPORTING i_object = 'ZCS4_OrdI' ).
          <orderitems>-Orderid = <orderitems>-%tmp-Orderid.
          <orderitems>-Customerid = <orderitems>-%tmp-Customerid.
        CATCH cx_root INTO DATA(ls_exp).
          APPEND VALUE #( %key = <orderitems>-%key
                          %pid = <orderitems>-%pid
                          %msg = new_message( id = 'ZCS04_MSG'
                                              number = '002'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = ls_exp->get_longtext(  )
                                              )
                            ) TO reported-orderitems.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Customer RESULT result.

ENDCLASS.

CLASS lhc_Customer IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
