require 'spec_helper'

describe Rapper do
  before(:each) do
    @valid_attributes = {
      :name => "Eminem",
      :album_count => 3
    }
  end

  it "creates a new instance given valid attributes" do
    Rapper.create!(@valid_attributes)
  end

  context "benchmarks" do
    before(:each) do
      REDIS.flushall
      @rapper = Rapper.create(@valid_attributes)
    end

    context "class methods" do
      it "stores creation benchmarks" do
        benchmarks = Rapper.create_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores update benchmarks" do
        Rapper.update(@rapper.id, {:name => "Ludacris"})
        benchmarks = Rapper.update_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores find benchmarks" do
        Rapper.find(@rapper.id)
        benchmarks = Rapper.find_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores first benchmarks" do
        Rapper.first
        benchmarks = Rapper.first_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores last benchmarks" do
        Rapper.last
        benchmarks = Rapper.last_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores all benchmarks" do
        Rapper.all
        benchmarks = Rapper.all_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores delete benchmarks" do
        Rapper.delete(@rapper.id)
        benchmarks = Rapper.delete_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores destroy benchmarks" do
        Rapper.destroy(@rapper.id)
        benchmarks = Rapper.destroy_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end
    end

    context "instance methods" do
      it "stores save benchmarks" do
        @rapper.name = "snoop"
        @rapper.save
        benchmarks = Rapper.save_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores update_attributes benchmarks" do
        @rapper.update_attributes(:name => "snoop")
        benchmarks = Rapper.update_attributes_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores delete benchmarks" do
        @rapper.delete
        benchmarks = Rapper.delete_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end

      it "stores destroy benchmarks" do
        @rapper.destroy
        benchmarks = Rapper.destroy_benchmarks
        benchmarks.should be_instance_of(Array)
        benchmarks.first.should be_instance_of(Hash)
      end
    end
  end
end
