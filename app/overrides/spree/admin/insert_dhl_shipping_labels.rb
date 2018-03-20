Deface::Override.new(virtual_path: 'spree/admin/orders/edit',
					 name: 'insert_dhl_shipping_labels',
					 insert_after: 'div[data-hook="admin_order_edit_form"]',
					 partial: 'spree/admin/orders/return_dhl_shipping_labels')