require 'spec_helper'

module JobshopWarehousex
  describe Item do
    it "should be OK" do
      c = FactoryGirl.create(:jobshop_warehousex_item)
      c.should be_valid
    end
    
    it "should reject 0 purchase_order_id" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :purchase_order_id => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :in_qty => 0)
      c.should_not be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :unit => nil)
      c.should_not be_valid
    end
    
    it "should reject nil in_date" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :in_date => nil)
      c.should_not be_valid
    end
    
    it "should reject nil item_name" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil spec" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :spec => nil)
      c.should_not be_valid
    end
    
    it "should reject nil storage_location" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :storage_location => nil)
      c.should_not be_valid
    end
    
    it "should reject if stock_qty > in_qty" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :in_qty => 1, :stock_qty => 2)
      c.should_not be_valid
    end
    
    it "should be OK if stock_qty == in_qty" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :in_qty => 1, :stock_qty => 1)
      c.should be_valid
    end
    
    it "should reject nil stock_qty" do
      c = FactoryGirl.build(:jobshop_warehousex_item, :stock_qty => nil)
      c.should_not be_valid
    end
  end
end
