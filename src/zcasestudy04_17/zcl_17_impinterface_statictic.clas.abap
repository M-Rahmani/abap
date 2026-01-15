CLASS zcl_17_impinterface_statictic DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES :
      zif_cs17_statistic.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_17_impinterface_statictic IMPLEMENTATION.

  METHOD zif_cs17_statistic~averagesales.
    TRY.
        sales_avg = 0.
        SELECT SINGLE
          FROM ZCDS17_Salesaverage
          FIELDS SalesAVG
          WHERE Customer = @i_customerid
          INTO @DATA(ls_result).
        IF sy-subrc = 0.
          sales_avg = ls_result.
        ELSE.
          sales_avg = 0.
        ENDIF.
      CATCH cx_sy_open_sql_error INTO DATA(lo_exc).
        RAISE EXCEPTION TYPE zcl_17_customer_error
          EXPORTING
            previous = lo_exc.
    ENDTRY.

  ENDMETHOD.

  METHOD zif_cs17_statistic~daysales.
    TRY.
        Sales_DAY = 0.
        SELECT SINGLE
          FROM ZCDS17_SALESDaily
          FIELDS SalesDaily
          INTO @DATA(ls_result).
        IF sy-subrc = 0.
          Sales_DAY = ls_result.
        ELSE.
          Sales_DAY = 0.
        ENDIF.
      CATCH cx_sy_open_sql_error INTO DATA(lo_exc).
        RAISE EXCEPTION TYPE zcl_17_customer_error
          EXPORTING
            previous = lo_exc.
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cs17_statistic~maxsales.
    TRY.
        Sales_MAX = 0.
        SELECT SINGLE
          FROM ZCDS17_SALESMAX
          FIELDS SalesMAX
          WHERE Customer = @i_customerid
          INTO @DATA(ls_result).
        IF sy-subrc = 0.
          Sales_MAX = ls_result.
        ELSE.
          Sales_MAX = 0.
        ENDIF.
      CATCH cx_sy_open_sql_error INTO DATA(lo_exc).
        RAISE EXCEPTION TYPE zcl_17_customer_error
          EXPORTING
            previous = lo_exc.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
