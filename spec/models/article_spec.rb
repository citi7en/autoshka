require 'spec_helper'

describe Article do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :rubric => "value for rubric",
      :content => "value for content",
      :autor => "value for autor",
      :release => 1,
      :date => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Article.create!(@valid_attributes)
  end
end
