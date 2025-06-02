CLASS zcl_open_vendor_invoices_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_amdp_marker_hdb.

    TYPES: BEGIN OF ty_open_vendor_invoices,
             rbukrs TYPE acdoca-rbukrs,
             gjahr  TYPE acdoca-gjahr,
             belnr  TYPE acdoca-belnr,
             budat  TYPE acdoca-budat,
             lifnr  TYPE acdoca-lifnr,
             name1  TYPE lfa1-name1,
             rtcur  TYPE acdoca-rtcur,
             tsl    TYPE acdoca-tsl,
             days   TYPE i,
           END OF ty_open_vendor_invoices.

    TYPES: tt_open_vendor_invoices TYPE STANDARD TABLE OF ty_open_vendor_invoices
                                        WITH DEFAULT KEY.

    CLASS-METHODS select
      IMPORTING VALUE(iv_where)                TYPE string
      EXPORTING VALUE(et_open_vendor_invoices) TYPE tt_open_vendor_invoices.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_open_vendor_invoices_amdp IMPLEMENTATION.


  METHOD select BY DATABASE PROCEDURE
                FOR HDB
                LANGUAGE SQLSCRIPT
                OPTIONS READ-ONLY
                USING acdoca lfa1.

    int_acdoca = APPLY_FILTER (acdoca, :iv_where);
    et_open_vendor_invoices = SELECT :int_acdoca.rbukrs,
                                     :int_acdoca.gjahr,
                                     :int_acdoca.belnr,
                                     :int_acdoca.budat,
                                     :int_acdoca.lifnr,
                                     lfa1.name1,
                                     :int_acdoca.rtcur,
                                     :int_acdoca.tsl,
                                     days_between (:int_acdoca.budat, current_date ) as days "open for x days
                                     FROM :int_acdoca
                                     INNER JOIN lfa1
                                           ON :int_acdoca.rclnt = lfa1.mandt AND
                                              :int_acdoca.lifnr = lfa1.lifnr;

  ENDMETHOD.
ENDCLASS.
