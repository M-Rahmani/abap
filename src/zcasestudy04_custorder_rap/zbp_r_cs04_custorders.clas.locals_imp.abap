CLASS LHC_ZR_CS04_CUSTORDERS DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrCs04Custorders
        RESULT result,
       Read_Status_FromList FOR VALIDATE ON SAVE
            IMPORTING keys FOR ZrCs04Custorders~Read_Status_FromList.
ENDCLASS.

CLASS LHC_ZR_CS04_CUSTORDERS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD Read_Status_FromList.

    DATA failed_record LIKE LINE OF failed-ZrCs04Custorders.
    READ ENTITIES OF zr_cs04_custorders IN LOCAL MODE
     ENTITY ZrCs04Custorders
    FIELDS ( Status ) WITH CORRESPONDING #( keys ) RESULT DATA(lt_data).
    LOOP AT lt_data INTO DATA(ls_data) WHERE Status IS NOT INITIAL.
      SELECT  COUNT( * ) FROM ZCS04_CStatus
       WHERE Status = @ls_data-Status
        INTO @DATA(lv_Status).
      IF  lv_Status  = 0.
        APPEND VALUE #( %tky = ls_data-%tky
                        %element-status = if_abap_behv=>mk-on
                        %msg = new_message( id = 'ZCS04_MSG'
                                            number = '005'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_data-Status
                                            )
                          ) TO reported-ZrCs04Custorders.

        failed_record-%tky = ls_data-%tky.
        APPEND failed_record TO failed-ZrCs04Custorders.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
