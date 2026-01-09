CLASS lhc_zr_cs04_customer DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS:
      adjust_numbers REDEFINITION.
ENDCLASS.

CLASS lhc_zr_cs04_customer IMPLEMENTATION.

  METHOD adjust_numbers.
    LOOP AT mapped-zrcs04customers ASSIGNING FIELD-SYMBOL(<customer>).
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
                            ) TO reported-zrcs04customers.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_cs04_customers DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrCs04Customers
        RESULT result,
      Read_Salutation_FromList FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs04Customers~Read_Salutation_FromList
        ,
      checkcountry FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs04Customers~checkcountry,
*      earlynumbering_create FOR NUMBERING
*        IMPORTING entities FOR CREATE ZrCs04Customers,
      set_SalesTarget FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrCs04Customers~set_SalesTarget,
      GetCities FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrCs04Customers~GetCities,
      validate_email FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs04Customers~validate_email.
ENDCLASS.

CLASS lhc_zr_cs04_customers IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Read_Salutation_FromList.
    DATA failed_record LIKE LINE OF failed-zrcs04customers.
    READ ENTITIES OF zr_cs04_customers IN LOCAL MODE
     ENTITY ZrCs04Customers
    FIELDS ( Salutation ) WITH CORRESPONDING #( keys ) RESULT DATA(lt_data).

    LOOP AT lt_data INTO DATA(ls_data) WHERE Salutation IS NOT INITIAL.
      SELECT  COUNT( * ) FROM zcs04_csalutation
       WHERE salutation = @ls_data-Salutation
        INTO @DATA(lv_Salutation).

      IF  lv_Salutation  = 0.
        APPEND VALUE #( %tky = ls_data-%tky
                        %element-salutation = if_abap_behv=>mk-on
                        %msg = new_message( id = 'ZCS04_MSG'
                                            number = '001'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_data-Salutation
                                            )
                          ) TO reported-zrcs04customers.

        failed_record-%tky = ls_data-%tky.
        APPEND failed_record TO failed-zrcs04customers.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

*  METHOD earlynumbering_create.
*    DATA failed_record LIKE LINE OF failed-zrcs04customers.
*    LOOP AT entities INTO DATA(ls_Customer) .
*      TRY.
*          ls_Customer-customerid = zcl_cs4_importcustomer=>get_customerid( EXPORTING i_object = 'ZCS4_NUR' ).
*          APPEND VALUE #( %cid = ls_Customer-%cid %is_draft = ls_Customer-%is_draft Customerid = ls_Customer-Customerid ) TO mapped-zrcs04customers.
*        CATCH cx_root INTO DATA(ls_exception).
*          APPEND VALUE #( %cid = ls_Customer-%cid
*                          %is_draft = ls_Customer-%is_draft
*                          %msg = new_message( id = 'ZCS04_MSG'
*                                              number = '002'
*                                              severity = if_abap_behv_message=>severity-error
*                                              v1 = ls_exception->get_longtext(  )
*                                              )
*                            ) TO reported-zrcs04customers.
*          failed_record-%cid = ls_Customer-%cid.
*          failed_record-%is_draft = ls_Customer-%is_draft.
*          APPEND failed_record TO failed-zrcs04customers.
*      ENDTRY.
*    ENDLOOP.
*  ENDMETHOD.

  METHOD set_SalesTarget.
    DATA: update_amount TYPE TABLE FOR UPDATE zr_cs04_customers.
    TRY.
        READ ENTITIES OF zr_cs04_customers IN LOCAL MODE
             ENTITY ZrCs04Customers
             FIELDS ( SalesVolume Currency CurrencyTarget ChangeRateDate )
             WITH CORRESPONDING #( keys  )
             RESULT DATA(Amounts)
             FAILED DATA(read_failed).
        LOOP AT Amounts INTO DATA(Amount) .
          IF Amount-SalesVolume = 0 OR Amount-Currency IS INITIAL OR  Amount-CurrencyTarget IS INITIAL.
            Amount-SalesVolumeTarget = 0.
          ELSE.
            cl_exchange_rates=>convert_to_foreign_currency( EXPORTING local_amount = Amount-SalesVolume
                                                            local_currency = Amount-Currency
                                                            foreign_currency = Amount-CurrencyTarget
                                                            date = COND #( WHEN Amount-ChangeRateDate IS INITIAL THEN sy-datum
                                                                                   ELSE Amount-ChangeRateDate )
                                                           IMPORTING  foreign_amount     = Amount-SalesVolumeTarget ).
          ENDIF.
          APPEND VALUE #( %tky = Amount-%tky SalesVolumeTarget = Amount-SalesVolumeTarget ) TO update_amount.
        ENDLOOP.
        IF update_amount IS NOT INITIAL.
          MODIFY ENTITIES OF zr_cs04_customers IN LOCAL MODE
              ENTITY ZrCs04Customers
              UPDATE FIELDS ( SalesVolumeTarget ) WITH update_amount
              REPORTED DATA(reported_records)
              FAILED   DATA(failed).
        ENDIF.
      CATCH cx_root INTO DATA(ls_exception).
        APPEND VALUE #( %tky = Amount-%tky
                        %msg = new_message( id = 'ZCS04_MSG'
                                            number = '003'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_exception->get_longtext(  )
                                            )
                          ) TO reported-zrcs04customers.
    ENDTRY.
  ENDMETHOD.

  METHOD GetCities.

    READ ENTITIES OF ZR_cs04_customers IN LOCAL MODE
      ENTITY  ZrCs04Customers
      FIELDS ( postcode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(customers) .

    LOOP AT customers INTO DATA(customer) .
      SELECT SINGLE
      FROM  zcs04_postcode
      FIELDS city
      WHERE postcode = @customer-postcode
      INTO ( @customer-city ).
      MODIFY customers FROM customer.
    ENDLOOP.
    DATA customer_upd TYPE TABLE FOR UPDATE zr_cs04_customers.
    customer_upd = CORRESPONDING #( customers ).

    MODIFY ENTITIES OF zr_cs04_customers IN LOCAL MODE
      ENTITY zrcs04Customers
      UPDATE
      FIELDS ( city )
      WITH customer_upd
      REPORTED DATA(reported_records).

    reported-zrcs04customers = CORRESPONDING #( reported_records-zrcs04customers ).

  ENDMETHOD.

  METHOD checkcountry.
    DATA failed_record LIKE LINE OF failed-zrcs04customers.
    TRY.
        READ ENTITIES OF zr_cs04_customers IN LOCAL MODE
             ENTITY ZrCs04Customers
             FIELDS ( country )
             WITH CORRESPONDING #( keys  )
             RESULT DATA(Countries)
             FAILED DATA(read_failed).
        LOOP AT Countries INTO DATA(Country) WHERE Country IS NOT INITIAL.

          SELECT SINGLE Country
            FROM ZCS04_Countries
            WHERE Country = @Country-Country
            INTO @DATA(lv_country).
          IF sy-subrc <> 0.
            APPEND VALUE #(
         %tky = Country-%tky
         %element-country = if_abap_behv=>mk-on
         %msg = new_message(
                  id   = 'ZCS04_MSG'
                  number = '004'
                  severity = if_abap_behv_message=>severity-error
                  v1 = Country-country
                   )
       ) TO reported-zrcs04customers.
            failed_record-%tky = Country-%tky.
            APPEND failed_record TO failed-zrcs04customers.
          ENDIF.
        ENDLOOP.
      CATCH cx_root INTO DATA(ls_exception).
        APPEND VALUE #(
          %tky = Country-%tky
          %element-country = if_abap_behv=>mk-on
          %msg = new_message(
                   id   = 'ZCS04_MSG'
                   number = '004'
                   severity = if_abap_behv_message=>severity-error
                   v1 = Country-country
                    )
        ) TO reported-zrcs04customers.
        failed_record-%tky = Country-%tky.
        APPEND failed_record TO failed-zrcs04customers.
    ENDTRY.
  ENDMETHOD.

  METHOD validate_email.

    READ ENTITIES OF ZR_cs04_customers IN LOCAL MODE
      ENTITY   ZR_cs04_customers
      FIELDS ( Email )
      WITH CORRESPONDING #( keys )
      RESULT DATA(customers).

    LOOP AT customers ASSIGNING FIELD-SYMBOL(<cust>).

      DATA(lv_email) = <cust>-Email.
*   if <cust>-Email is initial or <cust>-Email NP '*@*.*'.
      IF lv_email NP '*@*.*'.

*   failed-zcs04_copy_d = value #(
*        ( %tky = <cust>-%tky )
*        ).
        reported-zrcs04customers = VALUE #( (  %tky = <cust>-%tky
                                             %msg = new_message(
                                              id = 'ZMSG15'
                                              number = '001'
                                              severity = if_abap_behv_message=>severity-warning
                                              v1 = <cust>-email  ) ) ).

        CONTINUE.
      ENDIF.
      IF lv_email CA  ' !#$%&()*+,/:;>=<?{}?\|''"'.

*   failed-zcs04_copy_d = value #(
*        ( %tky = <cust>-%tky )
*        ).
        reported-zrcs04customers  = VALUE #( (  %tky = <cust>-%tky
                                             %msg = new_message(
                                              id = 'ZMSG15'
                                              number = '002'
                                              severity = if_abap_behv_message=>severity-warning
                                              v1 = <cust>-email  ) ) ).

        CONTINUE.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
