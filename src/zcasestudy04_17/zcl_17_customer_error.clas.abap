CLASS zcl_17_customer_error DEFINITION INHERITING FROM CX_STATIC_CHECK
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES :
    IF_T100_DYN_MSG,
    IF_T100_MESSAGE.
    CONSTANTS:
      BEGIN OF customer_not_found,
        msgid TYPE symsgid VALUE 'ZCS04_MSG',
      END OF customer_not_found.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_17_customer_error IMPLEMENTATION.
METHOD constructor  ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.


ENDCLASS.
