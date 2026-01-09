CLASS zcs04_16_list_umsaetze DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcs04_16_list_umsaetze IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  data test type table of zcs04_custorders.
*  select * from zcs04_custorders into CORRESPONDING FIELDS OF @test.
*  endselect.
*  out->write( test ).
**  update zcs04_custorders field
  ENDMETHOD.
ENDCLASS.
