require_dependency "jobshop_warehousex/application_controller"

module JobshopWarehousex
  class ItemsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
    
    def index
      @title = t('Warehouse Items')
      @items = params[:jobshop_warehousex_items][:model_ar_r]
      @items = @items.where(:purchase_order_id => @purchase_order.id) if @purchase_order
      @items = @items.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('warehouse_index_view', 'jobshop_warehousex_warehouses')
    end
  
    def new
      @title = t('New Warehouse Item')
      @item = JobshopWarehousex::Item.new()
      @erb_code = find_config_const('warehouse_new_view', 'jobshop_warehousex_warehouses')
    end
  
    def create
      @item = JobshopWarehousex::Item.new(params[:item], :as => :role_new)
      @item.last_updated_by_id = session[:user_id]
      @item.received_by_id = session[:user_id]
      @item.stock_qty = params[:item][:in_qty]
      if @item.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Warehouse Item')
      @item = JobshopWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('warehouse_edit_view', 'jobshop_warehousex_warehouses')
    end
  
    def update
      @item = JobshopWarehousex::Item.find_by_id(params[:id])
      @item.last_updated_by_id = session[:user_id]
      if @item.update_attributes(params[:item], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Warehouse Item Info')
      @item = JobshopWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('warehouse_show_view', 'jobshop_warehousex_warehouses')
    end
    
    protected
    def load_parent_record
      @purchase_order = JobshopWarehousex.po_class.find_by_id(params[:purchase_order_id]) if params[:purchase_order_id].present?
      @purchase_order = JobshopWarehousex.po_class.find_by_id(JobshopWarehousex::Item.find_by_id(params[:id]).purchase_order_id) if params[:id].present?
    end
  end
end
