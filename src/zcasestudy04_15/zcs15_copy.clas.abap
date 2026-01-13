class ZCS15_COPY definition
  public
  create private .
public section.

    INTERFACES if_oo_adt_classrun .
protected section.
private section.
ENDCLASS.



CLASS ZCS15_COPY IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  DATA lt_data TYPE STANDARD TABLE OF zcs15_Customers.

*  delete from zcs15_filedata.

  SELECT *
  FROM zcs04_Customers
  INTO CORRESPONDING FIELDS OF TABLE @lt_data.

 INSERT   zcs15_Customers
  FROM TABLE @lt_data.

 out->write( 'ok' ).

  ENDMETHOD.
ENDCLASS.
