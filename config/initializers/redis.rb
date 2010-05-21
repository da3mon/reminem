require "lib/extensions/abstract_adapter"

REDIS_DBS = {:production => 0, :development => 1, :staging => 2, :test => 3, :cucumber => 4}.with_indifferent_access
REDIS = Redis.new(:host => 'localhost', :db => REDIS_DBS[Rails.env.to_s])
