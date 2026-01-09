CLASS z04_fill_postcode DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z04_fill_postcode IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data post1 type table of zcs04_postcode.
data post2 type table of zcs04_postcode.
data post3 type table of zcs04_postcode.
*data city type table of zcity16.

    select
     from /DMO/I_agency
    fields distinct PostalCode as postcode, City as city
*      into  CORRESPONDING FIELDS OF @post.
 into table @post1.

 select
     from /DMO/I_Customer_StdVH
    fields distinct PostalCode as postcode, City as city
*      into  CORRESPONDING FIELDS OF @post.
 into table @post2.

 select
     from zcs04_customers
    fields distinct PostCode as postcode, City as city
*      into  CORRESPONDING FIELDS OF @post.
 into table @post3.
*       endselect.

out->write( 'Tabelle 1' ).
     out->write( post1 ).
     out->write( 'Tabelle 2' ).
      out->write( post2 ).
      out->write( 'Tabelle 3' ).
      out->write( post3 ).
     out->write( 'endet' ).

*     clear zcs04_postcode.
     insert   zcs04_postcode from table  @post1 accepting duplicate keys.
     insert   zcs04_postcode from table  @post2 accepting duplicate keys.
     insert   zcs04_postcode from table  @post3 accepting duplicate keys.
  ENDMETHOD.
ENDCLASS.
