Rails.application.routes.draw do

  mount JobshopWarehousex::Engine => "/jobshop_warehousex"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount InitEventTaskx::Engine => '/event_taskx'
  mount PurchaseOrderx::Engine => '/purchase_orderx'
  mount Supplierx::Engine => '/supplierx'
  mount InQuotex::Engine => '/in_quotex'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
