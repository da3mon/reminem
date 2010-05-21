class ActiveRecord::Base
  class << self
    def redis_benchmark(key, &blk)
      REDIS.lpush(benchmark_key_for(key), Benchmark.measure(Time.now.to_i * 1000) { blk.call }.to_json)
    end

    def benchmark_key_for(key)
      "benchmark:#{table_name}:#{key}"
    end

    def benchmarks_for(key)
      REDIS.lrange(benchmark_key_for(key), 0, -1).map {|h| JSON.parse(h)}
    end

    %w(find first last all create update delete destroy).each do |method_name|
      define_method "#{method_name}_with_redis_benchmark" do |*args|
        result = nil
        redis_benchmark(method_name) { result = send("#{method_name}_without_redis_benchmark", *args) }
        result
      end
      alias_method_chain method_name, :redis_benchmark

      define_method "#{method_name}_benchmarks" do
        benchmarks_for(method_name)
      end
    end

    %w(save update_attributes destroy).each do |method_name|
      define_method "#{method_name}_benchmarks" do
        benchmarks_for(method_name)
      end
    end    
  end

  %w(save update_attributes destroy delete).each do |method_name|
    define_method "#{method_name}_with_redis_benchmark" do |*args|
      result = nil
      self.class.redis_benchmark(method_name) { result = send("#{method_name}_without_redis_benchmark", *args) }
      result
    end
    alias_method_chain method_name, :redis_benchmark
  end
end