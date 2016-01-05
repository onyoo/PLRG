require 'spec_helper'

describe "Creates all objects in database." do
  before do

    @category = Category.create(username: "Math")
    @user = User.create(first_name: "Roberto")
    @topic = Topic.create(name: "Geometry", category: @category.id, user_id: @user.id)
    @resource = Resource.create(name: "textbook")
  end

  it "creates a user" do
    expect(@user).to be_valid
  end

  it "creates a category" do
    expect(@category).to be_valid
  end

  it "creates a topic" do
    expect(@topic).to be_valid
  end

  it "creates a resourec" do
    expect(@resource).to be_valid
  end
end