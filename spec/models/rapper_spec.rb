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
end
