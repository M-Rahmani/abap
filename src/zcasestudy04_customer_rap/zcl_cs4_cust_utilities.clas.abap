CLASS zcl_cs4_cust_utilities DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES :
      if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cs4_cust_utilities IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_original TYPE TABLE OF zc_cs04_customers000,
          ls_calc     TYPE zc_cs04_customers000.

    lt_original = CORRESPONDING #( it_original_data ).
    LOOP AT lt_original ASSIGNING FIELD-SYMBOL(<fs>) .
      SELECT SINGLE OrderCount FROM ZCS04_OrderCount( CustID = @<fs>-Customerid )
        INTO  @DATA(iv_ordercount).
      <fs>-ordercount = iv_ordercount.
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #( lt_original ).
  ENDMETHOD.
ENDCLASS.
