CLASS zcl_abapgitof DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
             DATA: name TYPE char30.
ENDCLASS.

CLASS zcl_abapgitof IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.
    out->write( 'Hello World!' ).
  ENDMETHOD.
ENDCLASS.







