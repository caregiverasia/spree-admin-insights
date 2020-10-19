Deface::Override.new(
  virtual_path:  'spree/admin/shared/_main_menu',
  name:          'add_insights_to_admin_side_menu',
  insert_bottom: 'nav',
  partial: 'spree/admin/shared/insights_side_menu',
)
