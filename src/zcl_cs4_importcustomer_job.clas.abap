CLASS zcl_cs4_importcustomer_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    InTERFACES :
      if_apj_dt_exec_object,
      if_apj_rt_exec_object
      .
  CLASS-METHODS:
    Import_File,
    Create_Customer.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cs4_importcustomer_job IMPLEMENTATION.


  METHOD if_apj_rt_exec_object~execute.
    Import_File(  ).
    create_customer(  ).
  ENDMETHOD.

  METHOD if_apj_dt_exec_object~get_parameters.

  ENDMETHOD.



  METHOD import_file.
    TRY.
        DATA(cls_Importfile) = NEW zcl_cs4_importdata( ).
        cls_Importfile->Import_File(  ).
    ENDTRY.
  ENDMETHOD.

  METHOD create_customer.
      TRY.
        DATA(cls_PostCustomer) = NEW zcl_cs4_postcustomer( ).
        cls_PostCustomer->post_customer(  ).

    ENDTRY.
  ENDMETHOD.

ENDCLASS.
