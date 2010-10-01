Object.send(:remove_const, :Rack)
$:.reject! {|x| x =~ /rack-[\d\.]+\/lib/}
$".reject {|x| x =~ /^rack\/.*\.rb$/}
$".delete('rack.rb')
Gem.loaded_specs.delete("rack")

ENV["RAILS_ENV"] ||= "production"
require File.expand_path("../config/application", __FILE__)

use Rails::Rack::LogTailer
use Rails::Rack::Static

run ActionController::Dispatcher.new