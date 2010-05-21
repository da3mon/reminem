require 'spec_helper'

describe Rapper do
  before(:each) do
    REDIS.flushall
    @rapper = Rapper.create(:name => "Eminem", :album_count => 3)
  end

  context "class method benchmarks" do
    it "stores creation" do
      benchmarks = Rapper.create_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores update" do
      Rapper.update(@rapper.id, {:name => "Ludacris"})
      benchmarks = Rapper.update_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores find" do
      Rapper.find(@rapper.id)
      benchmarks = Rapper.find_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores first" do
      Rapper.first
      benchmarks = Rapper.first_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores last" do
      Rapper.last
      benchmarks = Rapper.last_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores all" do
      Rapper.all
      benchmarks = Rapper.all_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores delete" do
      Rapper.delete(@rapper.id)
      benchmarks = Rapper.delete_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores destroy" do
      Rapper.destroy(@rapper.id)
      benchmarks = Rapper.destroy_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end
  end

  context "instance method benchmarks" do
    it "stores save" do
      @rapper.name = "snoop"
      @rapper.save
      benchmarks = Rapper.save_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores update_attributes" do
      @rapper.update_attributes(:name => "snoop")
      benchmarks = Rapper.update_attributes_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores delete" do
      @rapper.delete
      benchmarks = Rapper.delete_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end

    it "stores destroy" do
      @rapper.destroy
      benchmarks = Rapper.destroy_benchmarks
      benchmarks.should be_instance_of(Array)
      benchmarks.first.should be_instance_of(Hash)
    end
  end
end
