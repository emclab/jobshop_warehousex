require "jobshop_warehousex/engine"

module JobshopWarehousex
  mattr_accessor :po_class, :show_po_path, :checkout_resource, :index_checkout_path
  
  def self.po_class
    @@po_class.constantize
  end
end
