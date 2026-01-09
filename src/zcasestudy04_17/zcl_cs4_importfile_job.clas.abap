CLASS zcl_cs4_importfile_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS Read_File.
    CONSTANTS:
      gc_error   TYPE abap_char1 VALUE 'E',
      gc_warn    TYPE abap_char1 VALUE 'W',
      gc_info    TYPE abap_char1 VALUE 'I',
      gc_Success TYPE abap_char1 VALUE 'S'.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cs4_importfile_job IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  read_file(  ).

  ENDMETHOD.


  METHOD read_file.
    DATA:
      lt_file     TYPE TABLE OF ztl_00_casestudy,
      lt_customer TYPE TABLE OF zcs04_filedata WITH EMPTY KEY,
      ls_customer TYPE zcs04_filedata,
      lt_Line     TYPE TABLE OF string,
      lt_logTbl04 TYPE TABLE OF zcs04_logtbl,
      Result_flg  TYPE char1,
      Result_Msg  TYPE char256
      .

    TRY.
        DATA(cls_CheckCustomer) = NEW zcl_cs4_importcustomer( ).
        cls_CheckCustomer->Get_fileData(
          IMPORTING
            e_filerows = lt_file
            e_result   = Result_flg
            e_message  = Result_Msg
        ).
        IF Result_flg = abap_false.
          cls_CheckCustomer->insert_log( i_message = 'Table ztl_00_casestudy is Empty' i_errtype = gc_info ).
        ELSE.
          LOOP AT lt_file INTO DATA(ls_source).
            Result_flg = abap_true.
            CLEAR Result_Msg.
            cls_CheckCustomer->split_filerow(
              EXPORTING
                i_filerow  = ls_source
              IMPORTING
                e_customer = ls_customer
                e_result   = Result_flg
                e_message  = Result_Msg
            ).
            IF Result_flg = abap_false.
              cls_CheckCustomer->insert_log( i_message =  Result_Msg i_errtype = gc_error ).
              CONTINUE.
            ENDIF.
            Result_flg = abap_true.
            CLEAR Result_Msg.
            cls_CheckCustomer->insert_filerow(
              EXPORTING
                i_suuid     = ls_source-uuid
              IMPORTING
                e_result    = Result_flg
                e_message   = Result_Msg
              CHANGING
                ls_customer = ls_customer
            ).
            IF Result_flg = abap_false.
              CONTINUE.
            ENDIF.
            IF Result_Msg IS NOT INITIAL.
              cls_CheckCustomer->insert_log( i_message =  Result_Msg i_errtype = gc_error ).
            ENDIF.
            APPEND ls_customer TO lt_customer.
          ENDLOOP.

          SORT lt_customer BY company city street postcode medium mvalue1 mvalue2.
          DELETE ADJACENT DUPLICATES FROM lt_customer
            COMPARING company city street postcode medium mvalue1 mvalue2.
          MODIFY zcs04_filedata FROM TABLE @lt_customer.

          IF sy-subrc IS NOT INITIAL.
            cls_CheckCustomer->insert_log( i_message =  'Data couldnot insert ' i_errtype = gc_error ).
          ELSE.
            cls_CheckCustomer->insert_log( i_message =  'Data has been imported ' i_errtype = gc_success ).
          ENDIF.
        ENDIF.
      CATCH cx_sy_open_sql_db INTO DATA(lx_sql1).
        cls_CheckCustomer->insert_log( i_message =  | Data Couldnot Insert, Database Error: { lx_sql1->get_longtext( ) }| i_errtype = gc_error ).
      CATCH cx_root INTO DATA(lx_error1).
        cls_CheckCustomer->insert_log( i_message =   | Data Couldnot Insert, Error: { lx_error1->get_longtext( ) }| i_errtype = gc_error ).
      ENDTRY.
    MODIFY zcs04_logtbl FROM TABLE @lt_logTbl04.
  ENDMETHOD.

ENDCLASS.
