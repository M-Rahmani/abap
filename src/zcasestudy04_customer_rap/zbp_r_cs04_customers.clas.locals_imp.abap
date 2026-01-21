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
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrCs04Customers
        RESULT result,
      Read_Salutation_FromList FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs04Customers~Read_Salutation_FromList,
      checkcountry FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs04Customers~checkcountry,
*      earlynumbering_create FOR NUMBERING
*        IMPORTING entities FOR CREATE ZrCs04Customers,
      set_SalesTarget FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrCs04Customers~set_SalesTarget,
      GetCities FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrCs04Customers~GetCities,
      validate_email FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs04Customers~validate_email,
      CancelOrders FOR MODIFY
        IMPORTING keys FOR ACTION ZrCs04Customers~CancelOrders,
      ShowStatistics FOR MODIFY
        IMPORTING keys FOR ACTION ZrCs04Customers~ShowStatistics RESULT result.
    CLASS-METHODS :
      SetCancel_Orders IMPORTING Customer_id      TYPE zcustomerid04
                                 Order_id         TYPE zorderid04
                       EXPORTING NumberofUpdating TYPE int2
                                 UMessage         TYPE char72.
ENDCLASS.

CLASS lhc_zr_cs04_customers IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD SetCancel_Orders.
    NumberofUpdating = 0.
    CLEAR UMessage.
    DATA: update_Status TYPE TABLE FOR UPDATE zr_cs04_custorders,
          ls_OrderNo    TYPE zr_cs04_custorders.
    TRY.
        SELECT * FROM zr_cs04_custorders
         WHERE Customerid = @Customer_id
          AND status NOT IN ( 'BA', 'BS' ) INTO CORRESPONDING FIELDS OF @ls_OrderNo.
          APPEND VALUE #( Customerid = ls_OrderNo-Customerid Orderid = ls_OrderNo-Orderid status = 'BS' ) TO update_Status.
          IF update_Status IS NOT INITIAL.
            MODIFY ENTITIES OF zr_cs04_custorders
                ENTITY ZrCs04Custorders
                UPDATE FIELDS ( Status ) WITH update_Status
                REPORTED DATA(reported_records)
                FAILED   DATA(failed).
          ENDIF.
          NumberofUpdating += 1.
        ENDSELECT.
      CATCH cx_root INTO DATA(ls_exception).
        UMessage = ls_exception->get_longtext(  ).
    ENDTRY.
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
    DATA failed_record LIKE LINE OF failed-zrcs04customers.
    READ ENTITIES OF zr_cs04_customers IN LOCAL MODE
     ENTITY  ZrCs04Customers "zr_cs04_customers000
     FIELDS ( Email )
     WITH CORRESPONDING #( keys )
     RESULT DATA(customers).
      DATA e_Result TYPE abap_bool  VALUE abap_true.
      DATA: lv_pattern TYPE string VALUE
              '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$',
            lo_matcher TYPE REF TO cl_abap_matcher.
    LOOP AT customers ASSIGNING FIELD-SYMBOL(<cust>).
      DATA(lv_email) = <cust>-Email.
*    e_result  = abap_true.
*    CLEAR e_message.
*    new_email = i_customer-email.
      IF lv_email IS NOT INITIAL.
        TRY.
            lo_matcher = cl_abap_matcher=>create(
              pattern = lv_pattern
              text    = lv_email
            ).
          CATCH cx_root.
        ENDTRY.
        IF lo_matcher->match( ) = abap_false.
          reported-zrcs04customers = VALUE #( (  %tky = <cust>-%tky
                                            %element-email = if_abap_behv=>mk-on
                                            %msg = new_message(
                                             id = 'ZMSG15'
                                             number = '001'
                                             severity = if_abap_behv_message=>severity-error
                                             v1 = <cust>-email  ) ) ).
            failed_record-%tky = <cust>-%tky.
            APPEND failed_record TO failed-zrcs04customers.
        ENDIF.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD cancelorders.
    DATA : Up_Count      TYPE int2,
           UP_Message    TYPE char72,
           failed_record LIKE LINE OF failed-zrcs04customers.
    TRY.
        LOOP AT  keys INTO DATA(Custpomer) .
          setcancel_orders( EXPORTING customer_id = Custpomer-%param-customerid order_id = '' IMPORTING numberofupdating = Up_Count umessage = Up_message ).
          IF Up_message IS NOT INITIAL.
            APPEND VALUE #( %cid = Custpomer-%cid
                            %msg = new_message( id = 'ZCS04_MSG'
                                            number = '006'
                                           severity = if_abap_behv_message=>severity-error
                                           v1 = Up_message
                                              )
                           ) TO reported-zrcs04customers.
            failed_record-%cid = Custpomer-%cid.
            APPEND failed_record TO failed-zrcs04customers.
          ELSE.
            APPEND VALUE #( %cid = Custpomer-%cid
                  %msg = new_message( id = 'ZCS04_MSG'
                                  number = '007'
                                 severity = if_abap_behv_message=>severity-information
                                 v1 = Custpomer-%param-customerid
                                 v2 = CONV char13( Up_Count )
                                    )
                 ) TO reported-zrcs04customers.
          ENDIF.
        ENDLOOP.
      CATCH cx_root INTO DATA(ls_exception).
        APPEND VALUE #(  %msg = new_message( id = 'ZCS04_MSG'
                                            number = '006'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_exception->get_longtext(  )
                                            )
                          ) TO reported-zrcs04customers.
    ENDTRY.
  ENDMETHOD.

  METHOD ShowStatistics.
    DATA: lo_generic_instance TYPE REF TO object.
    SELECT SINGLE upper( interfname ) as interfname, upper( classname ) as classname
     FROM zcs04_statistics
     WHERE activstat = 'X'
     INTO @DATA(ls_config).
    IF sy-subrc <> 0.
    APPEND VALUE #( %msg = new_message( id = 'ZCS04_MSG'
                               number = '011'
                               severity = if_abap_behv_message=>severity-error
                                )
                      ) TO reported-zrcs04customers.
      RETURN.
    ENDIF.
    TRY.
        CREATE OBJECT lo_generic_instance TYPE (ls_config-classname).
        DATA(lo_class_descr) = CAST cl_abap_classdescr(
                                     cl_abap_typedescr=>describe_by_object_ref( lo_generic_instance )
                                   ).
        IF NOT line_exists( lo_class_descr->interfaces[ name = to_upper( ls_config-interfname ) ] ).
                APPEND VALUE #( %msg = new_message( id = 'ZCS04_MSG'
                               number = '010'
                               severity = if_abap_behv_message=>severity-error
                               v1 = ls_config-classname
                               v2 = ls_config-interfname
                                )
                      ) TO reported-zrcs04customers.
          RETURN.
        ENDIF.
      CATCH cx_sy_create_object_error.
        APPEND VALUE #( %msg = new_message( id = 'ZCS04_MSG'
                               number = '009'
                               severity = if_abap_behv_message=>severity-error
                               v1 = ls_config-classname
                                )
                    ) TO reported-zrcs04customers.
      CATCH cx_root INTO DATA(lo_excp).
                APPEND VALUE #(  %msg = new_message( id = 'ZCS04_MSG'
                                              number = '008'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = lo_excp->get_longtext(  )
                                              )
                            ) TO reported-zrcs04customers.
      RETURN.
    ENDTRY.
    READ ENTITIES OF zr_cs04_customers IN LOCAL MODE
      ENTITY ZrCs04Customers
        FIELDS ( CustomerID ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_customers).
    LOOP AT lt_customers ASSIGNING FIELD-SYMBOL(<ls_customer>).
      TRY.
      DATA: lv_avg TYPE zsales_volume04, lv_Max TYPE zsales_volume04, lv_Day TYPE zsales_volume04.
      DATA(lv_method_call) = to_upper( |{ ls_config-interfname }~averagesales| ).
      CALL METHOD lo_generic_instance->(lv_method_call)
          EXPORTING
            i_customerid = <ls_customer>-Customerid
          RECEIVING
            sales_avg    = lv_avg.
     DATA(lv_methodM_call) = to_upper( |{ ls_config-interfname }~maxsales| ).
        CALL METHOD lo_generic_instance->(lv_methodM_call)
          EXPORTING
            i_customerid = <ls_customer>-Customerid
          RECEIVING
            Sales_MAX    = lv_Max.
      DATA(lv_methodD_call) = to_upper( |{ ls_config-interfname }~daysales| ).
        CALL METHOD lo_generic_instance->(lv_methodD_call)
          RECEIVING
            Sales_DAY  = lv_Day.
          APPEND VALUE #( %msg = new_message( id = 'ZCS04_MSG'
                                   severity = if_abap_behv_message=>severity-information
                                   number = '012'
                                   v1 = <ls_customer>-CustomerID
                                   v2 = lv_avg
                                   v3 = lv_Max
                                   v4 = lv_Day
                                    )
                        ) TO reported-zrcs04customers.
        CATCH cx_root INTO DATA(lo_exc).
          APPEND VALUE #(  %msg = new_message( id = 'ZCS04_MSG'
                                              number = '006'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = lo_exc->get_longtext(  )
                                              )
                            ) TO reported-zrcs04customers.
      ENDTRY.
    ENDLOOP.
    result = VALUE #( FOR customer IN lt_customers ( %tky = customer-%tky
                                                     %param = customer ) ).
  ENDMETHOD.
ENDCLASS.
