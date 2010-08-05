ActionController::Routing::Routes.draw do |map|
  map.resources :tutorials
  map.tagged_tutorials '/tutorials/tagged/:tag', :controller => 'tutorials', :action => 'tagged'

  map.namespace(:admin, :path_prefix => 'refinery') do |admin|
    admin.resources :tutorials, :collection => {:update_positions => :post}
  end
end
