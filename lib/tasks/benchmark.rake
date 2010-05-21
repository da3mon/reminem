namespace :benchmark do
  desc "compare redis benchmarked models to normal models"
  task :compare => [:environment] do
    %w(find first last all create update delete destroy)
    without_redis = Benchmark.measure("create") { Rapper.create_without_redis_benchmark(:name => "humpty") }
    with_redis = Benchmark.measure("create") { Rapper.create(:name => "humpty") }

    rapper_without = nil
    rapper_with = nil

    without_redis = Benchmark.measure("create") { rapper_without = Rapper.create_without_redis_benchmark(:name => "humpty") }
    with_redis = Benchmark.measure("create") { rapper_with = Rapper.create(:name => "humpty") }
    puts "Create delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("find") { Rapper.find_without_redis_benchmark(rapper_without.id) }
    with_redis = Benchmark.measure("find") { Rapper.find(rapper_with.id) }
    puts "Find delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("first") { Rapper.first_without_redis_benchmark }
    with_redis = Benchmark.measure("first") { Rapper.first }
    puts "First delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("last") { Rapper.last_without_redis_benchmark }
    with_redis = Benchmark.measure("last") { Rapper.last }
    puts "Last delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("all") { Rapper.all_without_redis_benchmark }
    with_redis = Benchmark.measure("all") { Rapper.all }
    puts "All delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("update") { Rapper.update_without_redis_benchmark(rapper_without.id, :name => "eminem") }
    with_redis = Benchmark.measure("update") { Rapper.update(rapper_with.id, :name => "eminem") }
    puts "Update delta: #{with_redis.real - without_redis.real}"

    rapper_without.name = "eminem"
    rapper_with.name = "eminem"

    without_redis = Benchmark.measure("save") { rapper_without.save_without_redis_benchmark }
    with_redis = Benchmark.measure("save") { rapper_with.save }
    puts "Save delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("update") { rapper_without.update_attributes_without_redis_benchmark(:name => "eminem") }
    with_redis = Benchmark.measure("update") { rapper_with.update_attributes(:name => "eminem") }
    puts "Update Attributes delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("destroy") { rapper_without.destroy_without_redis_benchmark }
    with_redis = Benchmark.measure("destroy") { rapper_with.destroy }
    puts "Destroy (instance) delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("create") { rapper_without = Rapper.create_without_redis_benchmark(:name => "humpty") }
    with_redis = Benchmark.measure("create") { rapper_with = Rapper.create(:name => "humpty") }

    without_redis = Benchmark.measure("delete") { rapper_without.delete_without_redis_benchmark }
    with_redis = Benchmark.measure("delete") { rapper_with.delete }
    puts "Delete (instance) delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("create") { rapper_without = Rapper.create_without_redis_benchmark(:name => "humpty") }
    with_redis = Benchmark.measure("create") { rapper_with = Rapper.create(:name => "humpty") }

    without_redis = Benchmark.measure("destroy") { Rapper.destroy_without_redis_benchmark(rapper_without.id) }
    with_redis = Benchmark.measure("destroy") { Rapper.destroy(rapper_with.id) }
    puts "Destroy (class) delta: #{with_redis.real - without_redis.real}"

    without_redis = Benchmark.measure("create") { rapper_without = Rapper.create_without_redis_benchmark(:name => "humpty") }
    with_redis = Benchmark.measure("create") { rapper_with = Rapper.create(:name => "humpty") }

    without_redis = Benchmark.measure("delete") { Rapper.delete_without_redis_benchmark(rapper_without.id) }
    with_redis = Benchmark.measure("delete") { Rapper.delete(rapper_with.id) }
    puts "Delete (class) delta: #{with_redis.real - without_redis.real}"
  end
end