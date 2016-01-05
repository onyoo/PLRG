require 'spec_helper'

describe "Make and Associate a Category" do
  before do

    @category = Category.create(username: "Math")
    @user = User.create(first_name: "Roberto")
    @topic = Topic.create(name: "Geometry", category: @category.id, user_id: @user.id)
    @topic_2 = Topic.create(name: "Algebra", category: @category.id, user_id: @user.id)
  end

  it "has properties" do
    expect(@category.name).to eq("Math")
    (@category.id.class).should be_a_kind_of(Integer)
  end

  it "has many topics" do
    expect(@category.topics[1].name).to eq("Algebra")
    expect().to eq()
  end

end