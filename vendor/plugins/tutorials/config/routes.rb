ActionController::Routing::Routes.draw do |map|
  map.resources :tutorials

  map.namespace(:admin, :path_prefix => 'refinery') do |admin|
    admin.resources :tutorials, :collection => {:update_positions => :post}
  end
end
