*&---------------------------------------------------------------------*
*& Report Z_OPEN_VENDOR_INVOICES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_open_vendor_invoices.

TABLES: acdoca.

DATA go_alv TYPE REF TO cl_salv_table.

SELECT-OPTIONS: s_rbukrs FOR acdoca-rbukrs,
                s_gjahr  FOR acdoca-gjahr.

INITIALIZATION.

  s_gjahr[] = VALUE #( ( sign   = rs_c_range_sign-including
                         option = rs_c_range_opt-equal
                         low    = '2020' ) ).

START-OF-SELECTION.

  " Adding select options to WHERE condition
  DATA(lv_where) = cl_shdb_seltab=>combine_seltabs(
    it_named_seltabs = VALUE #(
      ( name = 'GJAHR' dref = REF #( s_gjahr[] ) )
      ( name = 'RBUKRS' dref = REF #( s_rbukrs[] ) ) )
    iv_client_field = 'RCLNT' ).

  " Adding more selections to WHERE condition
  lv_where = lv_where && ' AND KOART = ''K'''.
  lv_where = lv_where && ' AND AUGBL = '''''.

  zcl_open_vendor_invoices_amdp=>select(
    EXPORTING iv_where = lv_where
    IMPORTING et_open_vendor_invoices = DATA(gt_open_vendor_invoice) ).

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table = gt_open_vendor_invoice ).
    CATCH cx_salv_msg INTO DATA(lx_message).
  ENDTRY.

  go_alv->display( ).
