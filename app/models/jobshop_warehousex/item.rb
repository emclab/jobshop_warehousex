module JobshopWarehousex
  class Item < ActiveRecord::Base
    attr_accessor :rejected_noupdate, :unit_price, :supplier_name
    attr_accessible :in_date, :in_qty, :inspection, :name, :last_updated_by_id, :purchase_order_id, :received_by_id, :spec, :stock_qty, :storage_location,
                    :unit, :rejected, :unit_price,
                    :supplier_name,
                    :as => :role_new
    attr_accessible :in_date, :in_qty, :inspection, :name, :last_updated_by_id, :purchase_order_id, :received_by_id, :spec, :stock_qty, :storage_location,
                    :unit, :rejected, :unit_price,
                    :rejected_noupdate, :supplier_name,
                    :as => :role_update                
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :received_by, :class_name => 'Authentify::User'
    belongs_to :purchase_order, :class_name => JobshopWarehousex.po_class.to_s

    validates :name, :spec, :unit, :storage_location, :in_date, :presence => true
    validates_numericality_of :in_qty, :purchase_order_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :stock_qty, :less_than_or_equal_to => :in_qty
    validates :stock_qty, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  end
end
