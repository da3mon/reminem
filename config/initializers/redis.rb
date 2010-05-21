require "lib/extensions/abstract_adapter"

REDIS_DBS = {:production => 0, :development => 1, :test => 2}.with_indifferent_access
REDIS = Redis.new(:host => 'localhost', :db => REDIS_DBS[Rails.env.to_s])
