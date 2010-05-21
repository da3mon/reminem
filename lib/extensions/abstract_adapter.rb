class ActiveRecord::Base
  class << self
    def redis_benchmark(label, &blk)
      REDIS.set(benchmark_key_for(label), Benchmark.measure(label) { blk.call }.to_json)
    end

    def benchmark_key_for(label)
      "benchmark:#{table_name}:#{label}"
    end

    %w(find first last all create update delete destroy).each do |method_name|
      define_method "#{method_name}_with_redis_benchmark" do |*args|
        result = nil
        redis_benchmark(method_name) { result = send("#{method_name}_without_redis_benchmark", *args) }
        result
      end
      alias_method_chain method_name, :redis_benchmark

      define_method "#{method_name}_benchmarks" do
        JSON.parse(REDIS.get(benchmark_key_for(method_name)))
      end
    end

    %w(save update_attributes destroy).each do |method_name|
      define_method "#{method_name}_benchmarks" do
        JSON.parse(REDIS.get(benchmark_key_for(method_name)))
      end
    end    
  end

  %w(save update_attributes destroy).each do |method_name|
    define_method "#{method_name}_with_redis_benchmark" do |*args|
      result = nil
      self.class.redis_benchmark(method_name) { result = send("#{method_name}_without_redis_benchmark", *args) }
      result
    end
    alias_method_chain method_name, :redis_benchmark
  end
end