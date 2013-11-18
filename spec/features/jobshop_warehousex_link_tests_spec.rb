require 'spec_helper'

describe "LinkTests" do
  describe "GET /jobshop_warehousex_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'jobshop_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "JobshopWarehousex::Item.where(:rejected => false).order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'jobshop_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'jobshop_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'jobshop_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "record.received_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'create_warehouse_item', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      
      @q_task = FactoryGirl.create(:init_event_taskx_event_task)
      @q_task1 = FactoryGirl.create(:init_event_taskx_event_task, :name => 'a new name')
      @supplier = FactoryGirl.create(:supplierx_supplier)
      @q = FactoryGirl.create(:in_quotex_quote, :task_id => @q_task.id, :supplier_id => @supplier.id)
      @q1 = FactoryGirl.create(:in_quotex_quote, :task_id => @q_task1.id, :supplier_id => @supplier.id)
      @o = FactoryGirl.create(:purchase_orderx_order, :quote_id => @q.id)
      @o1 = FactoryGirl.create(:purchase_orderx_order, :quote_id => @q1.id)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      q = FactoryGirl.create(:jobshop_warehousex_item, :purchase_order_id => @o.id)
      log = FactoryGirl.create(:commonx_log, :resource_id => q.id, :resource_name => 'jobshop_warehousex_items')
      
      visit items_path
      #save_and_open_page
      page.should have_content('Warehouse Items')
      click_link 'Edit'
      page.should have_content('Edit Warehouse Item')
      #save_and_open_page
      visit items_path
      click_link q.id.to_s
      #save_and_open_page
      page.should have_content('Warehouse Item Info')
      click_link 'New Log'
      page.should have_content('Log')
      
      visit new_item_path(:purchase_order_id => @o1.id)
      #save_and_open_page
      page.should have_content('New Warehouse Item')
    end
  end
end
