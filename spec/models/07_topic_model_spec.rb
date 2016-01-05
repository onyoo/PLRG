require 'spec_helper'

describe "Make and Associate a Topic" do
  before do

    @category = Category.create(username: "Math")
    @user = User.create(first_name: "Roberto")
    @topic = Topic.create(name: "Geometry", category: @category.id, user_id: @user.id)
  end

  it "has properties" do
    expect(@topic.name).to eq("Geometry")
    (@topic.id.class).should be_a_kind_of(Integer)
  end

  it "has many topics" do
    expect(@topic.category_id).to eq(@category.id)
  end

end